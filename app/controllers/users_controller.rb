class UsersController < ApplicationController
before_action :authenticate_user!

  # Loads the student page
  def student_view
  end

  # Loads the teacher page
  def teacher_view
  end

end
