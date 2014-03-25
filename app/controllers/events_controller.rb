class EventsController < ApplicationController

  before_filter :allowed, only: :show
  before_filter :store_location
  before_filter :verify_is_admin,  only: [:new, :edit, :destroy, :update, :publish, :full, :over]
  before_filter :authenticate_user!, except: [:show]
  
  # GET /events
  # GET /events.json

  def rejoindre
    @event = Event.find(params[:id])
    current_user.participer!(@event)
    redirect_to :back
  end

  def publish
      @event = Event.find(params[:id])
      @event.publish
      redirect_to event_path(@event)
  end
  def full
      @event = Event.find(params[:id])
      @event.full
      redirect_to debate_path(@debate)
  end
  def over
      @event = Event.find(params[:id])
      @event.over
      redirect_to debate_path(@debate)
  end
  
  def vote
     value = params[:type] == "up" ? 1 :
     value = params[:type] == "down" ? -1 : 0
     @event = Event.find(params[:id])
     @event.add_or_update_evaluation(:votes, value, current_user)
     respond_to do |format|
       format.html {redirect_to :back}
       format.js
     end
  end
  
  def index
    @events = Event.all.sort { |x,y| y.created_at <=> x.created_at }.paginate(:page => params[:page], :per_page =>8)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end


private
 
 def verify_is_admin
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:admin?))
 end

 def allowed
   @event = Event.find(params[:id])
   if @event.state == "offline"
     redirect_to(root_path) unless current_user.try(:admin?)
   end
 end