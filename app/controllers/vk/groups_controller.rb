class Vk::GroupsController < Vk::ApplicationController
  def index
    @groups = Group.order(:name).all
    if stale?(@groups, public: true)
      @groups_by_year = Hash.new
      @groups.map do |i|
        (@groups_by_year[i.start_year] ||= []) << i
      end
      @groups_by_year = @groups_by_year.sort.reverse
    end
  end

  def schedule
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
    if stale?([@group, @from, @to], public: true)
      @schedule = Entity.order(:start).where(:group_id => @group, :start => @from..@to).includes(:teacher, :subject, :auditorium, :entity_type)
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