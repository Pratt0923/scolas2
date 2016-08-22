class InterestController < ApplicationController

  def index
    @subjects = Subject.all.sort_by(&:name)
  end

  def create
    current_user.interests = params[:interest][:interests].to_json
    if current_user.save
    else
      flash[:danger] = "Something went wrong!"
    end
    redirect_to root_path
  end
end
