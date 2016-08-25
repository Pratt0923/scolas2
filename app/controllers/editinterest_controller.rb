class EditinterestController < ApplicationController

  def index
    @interests = Subject.all
  end

  def create
    current_user.interests = params[:editinterest][:interests].to_json
    current_user.save
    flash[:success] = "Interests Updated!"
    redirect_to :root
  end
end
