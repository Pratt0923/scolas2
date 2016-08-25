class PlockController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    interest_index_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    interest_index_path(resource)
  end

  def new
    super
  end

  def create
    super
  end

  def edit
    @interests = current_user.interests
  end

  def update
    current_user.interests = params[:user][:interests].to_json
    current_user.save
    super
  end
end
