require 'date'
require 'json'
require 'net/http'

namespace :bfpstu do
  desc 'Import'
  task :import, [:from, :to]  => :environment  do |t, args|
    logger = Logger.new('log/import_bfpstu.log')

    logger.info "== Import all groups from #{args[:from]} to #{args[:to]}"
    puts "== Import all groups from #{args[:from]} to #{args[:to]}"

    university = University.find_or_create_by_name('БФ ПНИПУ')
    groups = university.groups.where(archive: false)
    #groups = Group.find_all_by_name('АТП-08в')
    groups.each do |group|
      i = 0

      logger.info "== Group:  #{group.name}"
      puts '== Group: ' + group.name

      getparams = { :group => group.name, :from => args[:from], :to => args[:to] }
      body = fetch('http://srv.cravs.org/schlude/get_json.php', getparams )

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
          entitytype = case entity['type']
            when "Л" then EntityType.find(2)
            when "ПЗ" then EntityType.find(3)
            when "Л/Р" then EntityType.find(4)
            when "Зач." then EntityType.find(5)
            when "К/Р" then EntityType.find(6)
            when "Тест" then EntityType.find(7)
            when "К/П" then EntityType.find(8)
            when "Экз" then EntityType.find(9)
            when "Конс" then EntityType.find(10)
            else
              logger.info "= Unknown type (#{entity['type']})"
              puts "= Unknown type (#{entity['type']})"
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

  desc 'Auto Import'
  task :autoimport do
    Rake::Task[bfpstu:import].invoke(Date.today, Date.today+30.days)
  end
end

def fetch(url, params)
  uri = URI(url)
  uri.query = URI.encode_www_form(params)
  #puts 'Fetch: ' + uri.to_s
  data = res = Net::HTTP.get_response(uri).body
  JSON.parse(data)
end

