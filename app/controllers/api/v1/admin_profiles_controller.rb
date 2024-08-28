# frozen_string_literal: true

module Api
  module V1
    class AdminProfilesController < ApplicationController
      before_action :set_admin_profile, only: %i[show update destroy]
      before_action :authorize_admin

      def index
        @admin_profiles = AdminProfile.all
        render json: @admin_profiles
      end

      def show
        render json: @admin_profile
      end

      def create
        @admin_profile = AdminProfile.new(admin_profile_params)

        if @admin_profile.save
          render json: @admin_profile, status: :created
        else
          render json: @admin_profile.errors, status: :unprocessable_entity
        end
      end

      def update
        if @admin_profile.update(admin_profile_params)
          render json: @admin_profile
        else
          render json: @admin_profile.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @admin_profile.destroy
      end

      private

      def set_admin_profile
        @admin_profile = AdminProfile.find(params[:id])
      end

      def admin_profile_params
        params.require(:admin_profile).permit(:user_id)
      end
    end
  end
end
