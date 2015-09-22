class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_locale, :set_headers, :set_sessions

  private
  def set_locale
    I18n.locale = I18n.default_locale
  end

  def set_headers
    response.headers.delete('X-Frame-Options')
    response.headers['P3P'] = 'CP="NOI ADM DEV COM NAV OUR STP"'
  end

  def set_sessions
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def need_auth
    if !@user
      redirect_to :controller => 'vk/pages', :action => 'start'
    end
  end
end
