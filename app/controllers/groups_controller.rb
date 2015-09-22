class GroupsController < ApplicationController
  def index
    @groups = Group.order(:name).where(archive: false)
  end

  def show
    if params.has_key?(:from) and params.has_key?(:to)
      @from = Date.parse(params[:from])
      @to = Date.parse(params[:to])
    else
      @from = Date.today
      @to = Date.today+10.days
    end
    @group = Group.find(params[:id])
    if stale?([@group, @from, @to], public: true)
      @schedule = Entity.order(:start).where(group_id: @group, start: @from..@to).eager_load(:teacher, :subject, :auditorium, :entity_type)
    end
  end
end