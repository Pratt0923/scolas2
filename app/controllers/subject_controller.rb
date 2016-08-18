class SubjectController < ApplicationController
  def index
    @subject = Subject.all.includes(:posts => [:user])
    @interests_array = []
    if current_user.interests
      @interests = JSON.parse(current_user.interests).each do |f|
        if Subject.find(f)
          @interests_array.push(Subject.find(f))
        end
      end
    else
      flash[:danger] = "you do not have any interests selected. Please select some in Edit Profile"
      redirect_to :back
    end
  end
end
