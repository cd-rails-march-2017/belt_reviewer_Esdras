class EventsController < ApplicationController

  def index
    if !session[:id]
      redirect_to '/users'
    else
      @user = User.find(session[:id])
      @home_events = Event.all.where(state: @user.state)
      @away_events = Event.all.where.not(state: @user.state)
    end
  end

  def create_event
    @event = Event.new(event_params)
    if @event.save
      redirect_to '/', notice: "Congratulations! You created a new event!"
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      redirect_to '/', notice: "Congratulations! You have updated this event!"
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to '/'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event= Event.find(params[:id])
    @event.destroy
    redirect_to '/', notice: 'You have sucessfully removed that event!'
  end

  def create_comment
    @comment = Comment.new(user_id: session[:id], event_id: params[:id], content: params[:content])
    if @comment.save
      redirect_to :back
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def cancelling
    @event = Event.find(params[:id])
    @user = User.find(session[:id])
    @event.users.destroy(@user)
    redirect_to '/'
  end

  def going
    @event = Event.find(params[:id])
    @user = User.find(session[:id])
    @event.users << @user
    @event.save
    redirect_to '/'
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :location, :state, :user_id)
    end

end
