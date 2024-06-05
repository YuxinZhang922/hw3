class PlacesController < ApplicationController

  def index
    if @current_user
      @places = Place.where({ "user_id" => @current_user["id"] })
    else
      redirect_to "/login"
    end
  end

  def show
    if @current_user
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"]  })
      Rails.logger.info "-----------------"
      Rails.logger.info @entries.count
    else
      redirect_to "/session/new"
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["place"]["name"]
    @place["user_id"] = @current_user["id"]
    @place.save
    redirect_to "/places"
  end

end
