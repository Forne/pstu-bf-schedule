class JsController < ApplicationController
  protect_from_forgery except: :sw
  before_action :set_user

  def sw
    @offline_page = '/offline'
    if @signed_in
      @offline_page += '?u='+@user.id.to_s
      if @user.group
        @offline_page += '&g='+@user.group_id.to_s
      end
    end
    respond_to do |format|
      format.js { render :file => 'pages/sw', :layout => false }
    end
  end

end