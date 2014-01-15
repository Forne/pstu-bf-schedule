class Vk::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  layout 'vk'

  before_filter :i

  private
  def i
    I18n.locale = I18n.default_locale
    response.headers.delete('X-Frame-Options')
    response.headers['P3P'] = 'CP="NOI ADM DEV COM NAV OUR STP"'
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def need_auth
    if !@user
      redirect_to :controller => 'vk/pages', :action => 'start'
    end
  end
end
