class ApplicationController < ActionController::API
  respond_to :json

  include Devise::Controllers::Helpers
  include ActionController::MimeResponds

  before_action :authenticate_user!

  def authorize_admin
    unless current_user&.admin?
      render json: { error: 'Unauthorized. Admin access required.' }, status: :unauthorized
    end
  end

  def authorize_executive
    unless current_user&.executive?
      render json: { error: 'Unauthorized. Executive access required.' }, status: :unauthorized
    end
  end

  def authorize_employee
    unless current_user&.employee?
      render json: { error: 'Unauthorized. Employee access required.' }, status: :unauthorized
    end
  end
end
