class EventsController < ApplicationController
  before_action :set_event, only: [:show]
  before_action :set_action

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order(:start_date)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_action
      @action = "events"
    end

end
