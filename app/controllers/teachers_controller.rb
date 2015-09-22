class TeachersController < ApplicationController
  def index
    @teachers = Teacher.order(:full_name)
  end

  def show
    if params.has_key?(:from) and params.has_key?(:to)
      @from = Date.parse(params[:from])
      @to = Date.parse(params[:to])
    else
      @from = Date.today
      @to = Date.today+10.days
    end
    @teacher = Teacher.find(params[:id])
    @schedule = Entity.eager_load(:group, :subject, :auditorium, :entity_type).where(teacher_id: @teacher, start: @from..@to).order(:start)
  end
end
