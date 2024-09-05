# frozen_string_literal: true

class BrpsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_executive

  def create
    service = Brps::CreateService.new(brp_params)
    @brp = service.execute!
    render json: @brp, status: :created
  end

  # GET /companies/:company_id/brps
  def by_company
    @brps = Brp.where(company_id: params[:company_id])
    render json: @brps, status: :ok
  end

  # def update
  #   service = Brps::UpdateService.new(@brp, brp_params)
  #   @brp = service.execute!
  #   render json: @brp, status: :ok
  # end

  # def destroy
  #   service = Brps::DeleteService.new(@brp)
  #   service.execute!
  #   head :no_content
  # end

  # def show
  #   service = Brps::ShowService.new(params[:id])
  #   @brp = service.execute!
  #   render json: @brp, status: :ok
  # end

  private

  def brp_params
    params.require(:brp).permit(:company_id, :year)
  end

  def set_brp
    @brp = Brp.find(params[:id])
  end
end
