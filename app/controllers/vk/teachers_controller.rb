class Vk::TeachersController < Vk::ApplicationController
  def index
    @teachers = Teacher.order(:full_name).all
    if stale?(@teachers, public: true)
        @teachers_by_abc = Hash.new
        @teachers.map do |i|
          (@teachers_by_abc[i.full_name[0]] ||= []) << i
        end
      end
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
      @schedule = Entity.order(:start).where(:teacher_id => @teacher, :start => @from..@to).includes(:group, :subject, :auditorium, :entity_type)
      @rasp = Hash.new
      @schedule.map do |i|
        (@rasp[i.start.to_date] ||= []) << i
      end
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
