class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_env

  private
  def set_env
    response.headers.delete('X-Frame-Options')
    response.headers['P3P'] = 'CP="NOI ADM DEV COM NAV OUR STP"'
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def need_auth
    if @user.nil?
      redirect_to :controller => 'pages', :action => 'start'
    end
  end
end
