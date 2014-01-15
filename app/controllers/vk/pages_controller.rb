class Vk::PagesController < Vk::ApplicationController
  def init
    if params.has_key?(:auth_key)
      if (Digest::MD5.hexdigest('3893502_' + params[:viewer_id] + '_09zerWjvcxQN49H87GOC')) ==  params[:auth_key]
        vk_user = JSON.parse(params[:api_result])['response'][0]
        @user = User.where(:vk_id => params[:viewer_id]).first_or_create(:first_name => vk_user['first_name'], :last_name => vk_user['last_name'], :sex => vk_user['sex'])
        # TODO: update user info
        session[:user_id] = @user.id
        start
      else
        flash[:notice] = 'Ошибка API Вконтакте! Ошибка проверки.'
        redirect_to :controller => 'vk/pages', :action => 'start'
      end
    else
      flash[:notice] = 'Ошибка API Вконтакте! Отсутствуют параметры.'
      redirect_to :controller => 'vk/pages', :action => 'start'
    end
  end

  def start
    if @user
      if @user.group
        redirect_to :controller=>'vk/schedule', :action => 'group', :id => @user.group.id
      else
        flash[:notice] = 'Необходимо выбрать группу!'
        redirect_to :controller=>'vk/user', :action => 'edit'
      end
    else
      redirect_to :controller=>'vk/pages', :action => 'wrong_auth'
    end
  end

  def banned
  end

  def wrong_auth
  end
end
