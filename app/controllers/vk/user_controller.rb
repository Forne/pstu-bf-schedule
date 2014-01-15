class Vk::UserController < Vk::ApplicationController
  before_filter :need_auth

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to :controller => 'vk/pages', :action => 'start'
    else
      render action: 'vk/user/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:group_id)
  end
end
