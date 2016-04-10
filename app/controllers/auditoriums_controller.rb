class AuditoriumsController < ApplicationController
  before_action :set_auditorium, only: [:show]

  # GET /auditoriums
  # GET /auditoriums.json
  def index
    @auditoriums = Auditorium.order(:name)
  end

  # GET /auditoriums/1
  # GET /auditoriums/1.json
  def show
    if params.has_key?(:from) and params.has_key?(:to)
      @from = Date.parse(params[:from])
      @to = Date.parse(params[:to])
    else
      @from = Date.today
      @to = Date.today+10.days
    end
    @schedule_view = 'aud'
    @schedule = Entity.eager_load(:teacher, :subject, :auditorium, :entity_type, :group).where(auditorium_id: @auditorium, start: @from..@to).order(:start)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auditorium
      @auditorium = Auditorium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auditorium_params
      params.fetch(:auditorium, {})
    end
end
