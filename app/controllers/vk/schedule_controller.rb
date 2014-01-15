class Vk::ScheduleController < Vk::ApplicationController
  before_filter :need_auth

  def group
  	@gid = params[:id]
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
    @schedule = Entity.order(:start).where(:group_id => @group, :start => @from..@to).includes(:teacher, :subject, :auditorium, :entity_type)
    @rasp = Hash.new
    @schedule.map do |i|
      (@rasp[i.start.to_date] ||= []) << i
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
