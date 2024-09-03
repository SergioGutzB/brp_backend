# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]
      before_action :authorize_admin, only: %i[index destroy]
      before_action :authorize_executive, only: [:create_employee]
      # skip_before_action :authenticate_user!, only: [:create]

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)
        @user.role = 'executive' # Forzamos el rol a ejecutivo

        if @user.save
          @user.create_executive_profile(executive_profile_params)
          render json: {
            message: 'Por favor, confirma tu cuenta a través del enlace enviado a tu correo electrónico.'
          }, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def create_employee # rubocop:disable Metrics/AbcSize
        @company = current_user.executive_profile.companies.find(params[:company_id])
        @user = User.new(employee_user_params.merge(role: 'employee'))

        if @user.save
          @employee_profile = @user.create_employee_profile(employee_profile_params.merge(company: @company))
          @employee_profile.create_personal_info(personal_info_params)
          @employee_profile.create_work_info(work_info_params)
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def employee_user_params
        params.require(:user).permit(:email, :password)
      end

      def executive_profile_params
        params.require(:executive_profile).permit(:full_name, :nit, :professional_card, :phone)
      end

      def employee_profile_params
        params.require(:employee_profile).permit(:first_name, :last_name)
      end

      def personal_info_params
        EmployeePermittedParams.personal_info_params(params.require(:personal_info))
      end

      def work_info_params
        EmployeePermittedParams.work_info_params(params.require(:work_info))
      end

      def authorize_executive
        unless current_user&.executive_profile
          render json: { error: 'Unauthorized. Executive access required.' }, status: :unauthorized
        end
      end
    end
  end
end
