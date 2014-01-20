class Vk::TeachersController < Vk::ApplicationController
  def index
    @teachers = Teacher.order(:full_name)
    @teachers_by_letter = @teachers.group_by(&:group_by_first_letter)
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
    @teacher = Teacher.find(params[:id])
    if stale?([@teacher, @from, @to], public: true)
      @schedule = Entity.order(:start).where(:teacher_id => @teacher, :start => @from..@to).eager_load(:group, :subject, :auditorium, :entity_type)
      @schedule_by_date = @schedule.group_by(&:group_by_date)
    end
  end

  def session?
    if Date.today < DateTime.new(2014, 02, 01)
      return true
    else
      return false
    end
  end
end