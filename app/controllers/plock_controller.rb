class PlockController < Devise::RegistrationsController
  def new
    super
  end

  def create
    if params[:user][:interests]
      super
      binding.pry
      current_user.interests = params[:user][:interests].to_json
      current_user.save
    else
      flash[:danger] = "you did not select any interests!"
      redirect_to :back
    end
  end

  def update
    if params[:user][:interests]
      current_user.interests = params[:user][:interests].to_json
      current_user.save
      super
    else
      flash[:danger] = "you did not select any interests!"
      redirect_to :back
    end
  end
end
