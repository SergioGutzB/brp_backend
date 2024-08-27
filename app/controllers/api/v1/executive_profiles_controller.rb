class Api::V1::ExecutiveProfilesController < ApplicationController
  before_action :set_executive_profile, only: [:show, :update, :destroy]
  before_action :authorize_admin, except: [:show, :update]
  before_action :authorize_executive, only: [:show, :update]

  def index
    @executive_profiles = ExecutiveProfile.all
    render json: @executive_profiles
  end

  def show
    render json: @executive_profile
  end

  def create
    @executive_profile = ExecutiveProfile.new(executive_profile_params)

    if @executive_profile.save
      render json: @executive_profile, status: :created
    else
      render json: @executive_profile.errors, status: :unprocessable_entity
    end
  end

  def update
    if @executive_profile.update(executive_profile_params)
      render json: @executive_profile
    else
      render json: @executive_profile.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @executive_profile.destroy
  end

  private

  def set_executive_profile
    @executive_profile = ExecutiveProfile.find(params[:id])
  end

  def executive_profile_params
    params.require(:executive_profile).permit(:user_id, :full_name, :nit, :professional_card, :phone)
  end

  def authorize_executive
    unless current_user.admin? || current_user.id == @executive_profile.user_id
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
