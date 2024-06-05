class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "You've logged in!"
        redirect_to "/places"
      else
        flash["notice"] = "Wrong password!"
        redirect_to "/sessions/new"
      end
    else
      flash["notice"] = "Wrong email!"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye"
    redirect_to "/sessions/new"
  end
end
  