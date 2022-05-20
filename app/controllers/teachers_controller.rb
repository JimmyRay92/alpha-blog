class TeachersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  def index
    # checks whether params is defined. If so, it runs filtering method. If not, loads all teacher profiles
    if defined? params[:style][:name]
      @teachers = filter_teacher_profiles_by_style(params[:style][:name])
    else
      @teachers = Teacher.all
    end

    # Loads all Styles for filtering form
    @style = Style.new
   
  end

  # Method used for filtering Teacher profiles by style
  def filter_teacher_profiles_by_style(styles)
    Teacher.where(id: TeachersStyle.where(style_id: styles).map{|x| x.teacher_id}.uniq)
  end

  # Show a single profile
  def show
  end

  # Sets up the form for Profile creation. A new teacher object is created and all styles loaded into the instance variable.
  def new
    @teacher = Teacher.new
    @styles = Style.all
  end

  # Create a new Teacher Profile
  def create

      # Teacher Profile creation
      @teacher = Teacher.new(profile_params)
      @teacher.user_id = current_user.id
      @teacher.save

    if @teacher.save

      # Adds a style with the speciality marked as true in teachers_styles join table
      add_speciality_style(params[:teacher][:speciality])

      # Adds all other styles to the profile
      add_other_styles(params[:teacher][:styles])

      flash[:notice] = "Teacher profile created successfully"

      redirect_to teacher_path(current_user.teacher.id)

    else
      render 'new'
    end
  end

  # used for adding the speciality style to the Teachers Profile. Searches then adds the style. Changes the speciality attribute in the Teachers_style join table to 'true'.
  def add_speciality_style(style)
    speciality = Style.find(style)
    current_user.teacher.styles << speciality
    current_user.teacher.teachers_styles.first.update(speciality: true)
  end

  # Checks whether a a checkbox is ticket first. If so it searches and adds each style to the Teacher Profile. If no checkboxes are ticked, 'other styles' is left blank.
  def add_other_styles(styles)
    if styles.present?
      if styles.kind_of?(Array)
        styles.each do |style|
          found_style = Style.find(style)
          current_user.teacher.styles << found_style
        end
      else
        found_style = Style.find(styles)
        current_user.teacher.styles << found_style
      end
    end
  end

  # Edit a single Teacher Profile
  def edit
  end

  # Updating a Teacher Profile
  def update
  
    # Updates all the attributes in Teacher Table of the Profile
    @teacher.update(profile_params)
    @teacher.save

    # Checks if saved correctly. If ok, continues with adding styles. Otherwise redirects to form with validation errors displayed
    if @teacher.save

      # Deletes all associated styles first
      @teacher.styles.delete_all

      # Adds the speciality style to the teacher profile
      add_speciality_style(params[:teacher][:speciality])

      # Checks if the params is exists and if there are multiple other styles first, then adds the styles
      add_other_styles(params[:teacher][:styles])

      flash[:notice] = "Teacher profile edited successfully"

      redirect_to teacher_path(current_user.teacher.id)

    else
      render 'edit'
    end
  end

  # Deletes the current users' Teacher Profile
  def destroy
    @teacher.destroy

    redirect_to teachers_path
  end

  private

  # Finds a Teacher Profile
  def find_profile
    @teacher = Teacher.find(params[:id])
  end

  def profile_params
    params.require(:teacher).permit(:availability, :price, :lesson_length, :bio, :teaching_info, :picture)
  end

  def styles_params
    params.require(:teacher).permit(:speciality, :styles)
  end

end
