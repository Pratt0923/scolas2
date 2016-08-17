class PlockController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    binding.pry
    current_user.interests = params[:user][:interests].to_json
    if current_user.save
      flash[:success] = "User Created!"
    else
      flash[:danger] = "Something went wrong!"
    end
  end

  def update
    current_user.interests = params[:user][:interests].to_json
    current_user.save
    super
  end
end
