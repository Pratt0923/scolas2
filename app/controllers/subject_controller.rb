class SubjectController < ApplicationController
  def index
    @subject = Subject.all.includes(:posts => [:user])
    @interests_array = []
    if current_user.interests != "null"
      JSON.parse(current_user.interests).each do |f|
        if Subject.find(f)
          @interests_array.push(Subject.find(f))
        end
      end
    end
  end
end
