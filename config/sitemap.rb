SitemapGenerator::Sitemap.default_host = 'https://schedule.cravs.com'

SitemapGenerator::Sitemap.create do
  add groups_path, :priority => 1, :changefreq => 'weekly'
  add teachers_path, :priority => 1, :changefreq => 'weekly'
  add auditoriums_path, :priority => 0.9, :changefreq => 'weekly'

  Group.where(archive: false).find_each do |group|
    add group_path(group), :lastmod => group.updated_at, :priority => 0.8, :changefreq => 'daily'
  end

  Teacher.find_each do |teacher|
    add teacher_path(teacher), :priority => 0.7, :changefreq => 'daily'
  end

  Auditorium.find_each do |aud|
    add auditorium_path(aud), :priority => 0.6, :changefreq => 'daily'
  end
end