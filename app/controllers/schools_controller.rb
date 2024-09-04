class SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school, only: [:create_step_2, :create_step_3, :create_step_4]

  def index
    if params[:location_id]
      @schools = School.where(location_id: params[:location_id])
    else
      @schools = School.all
    end

    respond_to do |format|
      format.html # Pour le rendu standard HTML
      format.turbo_stream { render partial: 'schools/schools_list', locals: { schools: @schools } }
    end
    

    @schools = @schools.order(created_at: :desc).limit(6).offset(params[:offset] || 0)

    @locations = Location.all

    # @markers = @schools.geocoded.map do |school|
    #   {
    #     lat: school.latitude,
    #     lng: school.longitude,
    #     info_window: render_to_string(partial: "info_window", locals: { school: school })
    #   }
    # end
  end

  def show
    @school = School.find(params[:id])

    # Horaires d'ouverture associés à l'école
    # @opening_hours = @school.opening_hours

    # Reviews associés à l'école
    # @reviews = @school.reviews.includes(:user)

    # Données pour le marqueur sur la carte
    # @marker = {
    #   lat: @school.latitude,
    #   lng: @school.longitude,
    #   info_window: render_to_string(partial: "info_window", locals: { school: @school })
    # }
  end


    def new
    @school = School.new
    @locations = Location.all # Pour l'étape 4
  end

  def create_step_1
    @school = School.new(school_params_step_1)
    if @school.save
      redirect_to new_school_path(step: 2) # Aller à l'étape 2
    else
      render :new
    end
  end

  def create_step_2
    if @school.update(school_params_step_2)
      redirect_to new_school_path(step: 3) # Aller à l'étape 3
    else
      render :new
    end
  end

  def create_step_3
    if @school.update(school_params_step_3)
      redirect_to new_school_path(step: 4) # Aller à l'étape 4
    else
      render :new
    end
  end

  def create_step_4
    if @school.update(school_params_step_4)
      redirect_to @school, notice: 'Établissement créé avec succès.' # Finaliser la création
    else
      render :new
    end
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params_step_1
    params.require(:school).permit(:name, :address, :phone, :website, :email)
  end

  def school_params_step_2
    params.require(:school).permit(:description)
  end

  def school_params_step_3
    params.require(:school).permit(:rental, :levels)
  end

  def school_params_step_4
    params.require(:school).permit(:fee, :facebook, :instagram, :location_id)
  end
end
