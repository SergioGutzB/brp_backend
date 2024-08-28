# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json
      skip_before_action :verify_signed_out_user, only: :destroy

      def create
        user = User.find_by_email(sign_in_params[:email])

        if user&.valid_password?(sign_in_params[:password])
          @current_user = user
          token = generate_jwt_token(user)
          render json: {
            message: 'Logged in successfully.',
            token:
          }, status: :ok
        else
          render json: { error: 'Invalid email or password.' }, status: :unauthorized
        end
      end

      private

      def sign_in_params
        params.permit(:email, :password)
      end

      def generate_jwt_token(user)
        JWT.encode(
          { sub: user.id, exp: 24.hours.from_now.to_i },
          Rails.application.credentials.secret_key_base
        )
      end

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: {
            status: { code: 200, message: 'Logged in successfully.' },
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }
        else
          render json: {
            status: { code: 401, message: 'Invalid email or password.' }
          }, status: :unauthorized
        end
      end

      def respond_to_on_destroy
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
          Rails.application.credentials.fetch(:secret_key_base)).first
        current_user = User.find(jwt_payload['sub'])
        if current_user
          render json: {
            status: 200,
            message: 'Logged out successfully.'
          }, status: :ok
        else
          render json: {
            status: 401,
            message: "Couldn't find an active session."
          }, status: :unauthorized
        end
      end

      def current_token
        request.env['warden-jwt_auth.token']
      end
    end
  end
end
