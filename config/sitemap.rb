SitemapGenerator::Sitemap.default_host = 'http://show.cravs.com'

SitemapGenerator::Sitemap.create do
  add groups_path, :priority => 1, :changefreq => 'daily'

  Group.find_each do |group|
    add group_path(group), :lastmod => group.updated_at
  end

  add teachers_path, :priority => 1, :changefreq => 'daily'

  Teacher.find_each do |teacher|
    add teacher_path(teacher)
  end
end
