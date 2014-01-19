class Web::GroupsController < Web::ApplicationController
  def index
    @groups = Group.order(:name)
    @groups_by_start_year = @groups.group_by(&:start_year).sort
  end

  def schedule
    if session? and !params.has_key?(:to)
      @session = true
      @from = Date.today
      @to = Date.today+30.days
    elsif params.has_key?(:from) and params.has_key?(:to)
      @from = Date.parse(params[:from])
      @to = Date.parse(params[:to])
    else
      @from = Date.today
      @to = Date.today+10.days
    end
    @group = Group.find(params[:id])
    if stale?([@group, @from, @to], public: true)
      @schedule = Entity.order(:start).where(:group_id => @group, :start => @from..@to).includes(:teacher, :subject, :auditorium, :entity_type)
      @schedule_by_date = @schedule.group_by(&:group_by_date)
    end
  end

  def session?
    if Date.today < DateTime.new(2014,02,01)
      return true
    else
      return false
    end
  end
end