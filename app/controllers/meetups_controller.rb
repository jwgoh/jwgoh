class MeetupsController < ApplicationController
  #respond_to :html, :json

  #def index
  #end

  #def show
  #end

  def new
  end

  def create
    @meetup = Meetup.new(meetup_params)
    if @meetup.save
      render json: { success: true }
    else
      render json: { errors: @meetup.errors.full_messages }, status: 422
    end
  end

  #def edit
  #end

  #def update
  #end

  #def destroy
  #end
  
  private

  def meetup_params
    params.require(:meetup).permit(:title, :description, :date, :seo)
  end
end
