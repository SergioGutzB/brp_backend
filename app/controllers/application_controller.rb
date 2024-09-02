# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  include Devise::Controllers::Helpers
  include ActionController::MimeResponds

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

  private

  def authenticate_user!
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
        Rails.application.credentials.secret_key_base).first
      @current_user_id = jwt_payload['sub']
    end

    render json: { error: 'Not Authorized' }, status: 401 unless signed_in?
  end

  def signed_in?
    @current_user_id.present?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end
end
