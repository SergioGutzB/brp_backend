class Api::V1::CompaniesController < ApplicationController
  before_action :authorize_executive
  
  def create
    @company = current_user.executive_profile.companies.new(company_params)
    if @company.save
      render json: @company, status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def authorize_executive
    unless current_user&.executive_profile
      render json: { error: 'Unauthorized. Executive access required.' }, status: :unauthorized
    end
  end
end
