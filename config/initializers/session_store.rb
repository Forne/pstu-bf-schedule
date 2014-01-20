# Be sure to restart your server when you modify this file.

#Schedule::Application.config.session_store :cookie_store, key: 'schedule_session'
Schedule::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 120.minutes
