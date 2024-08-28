# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      skip_before_action :authenticate_user!, only: [:create]
      respond_to :json

      def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        build_resource(sign_up_params)
        resource.save
        if resource.persisted?
          if resource.active_for_authentication?
            render json: {
              status: { code: 200, message: 'Signed up successfully.' },
              data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
            }
          else
            render json: {
              status: { code: 401, message: 'Signed up but not authorized.' }
            }, status: :unauthorized
          end
        else
          render json: {
            status: {
              code: 422,
              message: "User couldn't be created successfully. #{ resource.errors.full_messages.to_sentence }"
            }
          }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role)
      end
    end
  end
end
