every 12.hours do
  rake 'bfpstu:import'
end

every 3.days do
  rake 'sitemap:refresh'
end