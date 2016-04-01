class UsersController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @users = @group.users
  end
end