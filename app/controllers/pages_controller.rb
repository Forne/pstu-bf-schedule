class PagesController < ApplicationController
  before_action :set_user

  def vk_init
    if params.has_key?(:auth_key)
      if (Digest::MD5.hexdigest(Rails.application.secrets.vk_app_key + '_' + params[:viewer_id] + '_' + Rails.application.secrets.vk_app_secret)) == params[:auth_key]
        vk_user = JSON.parse(params[:api_result])['response'][0]
        @user = User.where(:vk_id => params[:viewer_id]).first_or_create(:first_name => vk_user['first_name'], :last_name => vk_user['last_name'], :sex => vk_user['sex'])
        # TODO: update user info
        session[:user_id] = @user.id
        cookies[:user_ls] = 'vk'
        redirect_to :controller => 'pages', :action => 'start'
      else
        flash[:notice] = 'Ошибка API Вконтакте: Проверка не удалась.'
        redirect_to :controller => 'pages', :action => 'start'
      end
    else
      flash[:notice] = 'Ошибка API Вконтакте: Отсутствуют параметры.'
      redirect_to :controller => 'pages', :action => 'start'
    end
  end

  def callback
    if auth_hash['info']
      vk_user = auth_hash['info']
      @user = User.where(:vk_id => auth_hash['uid']).first_or_create(:first_name => vk_user['first_name'], :last_name => vk_user['last_name'], :sex => auth_hash['extra']['raw_info']['sex'])
      #flash[:notice] = vk_user['first_name'] + vk_user['last_name'] + auth_hash['extra']['raw_info']['sex'].to_s
      session[:user_id] = @user.id
      cookies[:user_ls] = 'web'
      redirect_to :controller => 'pages', :action => 'start'
    else
      flash[:notice] = 'Что-то пошло не так! :('
      redirect_to :controller => 'pages', :action => 'start'
    end
  end

  def start
    if @user
      if @user.group_id
        @from = Date.today
        @to = Date.today+10.days
        @schedule = Entity.eager_load(:teacher, :subject, :auditorium, :entity_type).where(group_id: @user.group_id, start: @from..@to).order(:start)
      end
    end
  end

  def offline
    @offline = true
    if params[:u]
      @user = User.find(params[:u])
    end
    if @user
      if @user.group_id
        @from = Date.today
        @to = Date.today+30.days
        @schedule = Entity.eager_load(:teacher, :subject, :auditorium, :entity_type).where(group_id: @user.group_id, start: @from..@to).order(:start)
      end
    end
    render 'offline', :layout => 'offline'
  end

  def logout
    session[:user_id] = nil
    session[:user_ls] = nil
    redirect_to :controller => 'pages', :action => 'start'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
