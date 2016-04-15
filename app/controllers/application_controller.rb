class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_env, :set_locale, :set_user_ls

  private
  def set_env
    response.headers.delete('X-Frame-Options')
    response.headers['P3P'] = 'CP="NOI ADM DEV COM NAV OUR STP"'
    @signed_in ||= true if session[:user_id]
  end

  def set_locale
    I18n.locale = extract_locale_from_params || extract_locale_from_env || I18n.default_locale
  end

  def set_user
    if session[:user_id]
      @user = User.where(:id => session[:user_id]).first
      if @user.blank?
        session[:user_id] = nil
        cookies[:user_ls] = nil
      end
    end
  end

  def set_user_ls
    if cookies[:user_ls]
      @user_ls = cookies[:user_ls]
    else
      @user_ls = ''
    end
  end

  def extract_locale_from_session
    parsed_locale = session[:locale]
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil if parsed_locale.present?
  end

  def extract_locale_from_params
    parsed_locale = params[:locale]
    if parsed_locale.present?
      if I18n.available_locales.include?(parsed_locale.to_sym)
        session[:locale] = parsed_locale
        return parsed_locale
      end
    end
  end

  def extract_locale_from_header
    if request.env['HTTP_ACCEPT_LANGUAGE'].present?
      parsed_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    end
  end

  def extract_locale_from_env
    if ENV['LOCALE'].present?
      parsed_locale = ENV['LOCALE']
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    end
  end

  def need_auth
    if @user.nil?
      redirect_to :controller => 'pages', :action => 'start'
    end
  end
end
