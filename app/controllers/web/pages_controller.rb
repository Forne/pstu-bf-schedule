class Web::PagesController < Web::ApplicationController
  def welcome
    redirect_to :controller => 'web/groups', :action => 'index'
  end
end
