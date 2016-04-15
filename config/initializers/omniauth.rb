Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, Rails.application.secrets.vk_site_key, Rails.application.secrets.vk_site_secret
end