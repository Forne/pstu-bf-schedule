class UserController < ApplicationController
  before_filter :set_user, :need_auth

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to :controller => 'pages', :action => 'start'
    else
      render action: 'user/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:group_id)
  end
end
