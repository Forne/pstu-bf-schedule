require 'date'
require 'json'
require 'net/http'

namespace :bfpstu do
  desc 'Import'
  task :import, [:from, :to]  => :environment  do |t, args|
    args.with_defaults(:from => Time.now.strftime("%d.%m.%Y"), :to => (Time.now+30.days).strftime("%d.%m.%Y"))
    logger = Logger.new('log/import_bfpstu.log')

    logger.info "== Import all groups from #{args[:from]} to #{args[:to]}"
    puts "== Import all groups from #{args[:from]} to #{args[:to]}"

    university = University.find_or_create_by(name: 'БФ ПНИПУ')
    groups = university.groups.where(archive: false)
    groups.each do |group|
      i = 0

      logger.info "== Group:  #{group.name}"
      puts '== Group: ' + group.name

      getparams = { :group => group.name, :from => args[:from], :to => args[:to] }
      body = fetch('http://srv-php.l.cravs.com/bfpstu-show-parser/get_json.php', getparams )
      if body.first['error'].present?
        puts body.first['error']
      end
      next if body.first['error'].present?

      Entity.destroy_all(:group_id => group, :start => args[:from].to_datetime..args[:to].to_datetime)

      body.each do |entity|
        if group.name == entity['group']
          # Auditorium find
          aud = university.auditoriums.find_by(shot_name: entity['cabinet'])
          if aud.blank?
            aud = university.auditoriums.create(
                name: entity['cabinet'],
                shot_name: entity['cabinet']
            )
            logger.info "= Create auditorium (#{aud.name})"
            puts "= Create auditorium (#{aud.name})"
          end

          # Entity type
          entitytype = EntityType.find_by(shot_name: entity['type'])
          if entitytype.blank?
            entitytype = EntityType.create(
                name: entity['type'],
                shot_name: entity['type'],
                important: false
            )
            logger.info "= Create type (#{entitytype.name})"
            puts "= Create type (#{entitytype.name})"
          end

          # Subject find
          subject = university.subjects.find_by(shot_name: entity['subject'])
          if subject.blank?
            subject = university.subjects.create(
                name: entity['subject'],
                shot_name: entity['subject']
            )
            logger.info "= Create subject (#{subject.name})"
            puts "= Create subject (#{subject.name})"
          end

          # Teacher find
          teacher = university.teachers.find_by(full_name: entity['teacher'])
          if teacher.blank?
            teacher = university.teachers.create(
                full_name: entity['teacher']
            )
            logger.info "= Create teacher (#{teacher.full_name})"
            puts "= Create teacher (#{teacher.full_name})"
          end

          group.entities.create(
              start: DateTime.strptime(entity['data'] + entity['start'], '%d.%m.%Y%H.%M'),
              end: DateTime.strptime(entity['data'] + entity['end'], '%d.%m.%Y%H.%M'),
              subject: subject,
              auditorium: aud,
              teacher: teacher,
              entity_type: entitytype
          )
          i = i + 1
        else
          logger.info "= Error! Group #{entity['group']} != #{group.name}. Date: #{entity['data']} #{entity['start']}. Subject: #{entity['subject']}"
          puts "= Error! Group #{entity['group']} != #{group.name}. Date: #{entity['data']} #{entity['start']}. Subject: #{entity['subject']}"
        end
      end

      logger.info "== Total imported: #{i}"
      puts "== Total imported: #{i}"
    end
  end
end

def fetch(url, params)
  uri = URI(url)
  uri.query = URI.encode_www_form(params)
  #puts 'Fetch: ' + uri.to_s
  data = Net::HTTP.get_response(uri).body
  JSON.parse(data)
end

