# frozen_string_literal: true

class EmployeeProfileSerializer < ActiveModel::Serializer
  # except user_parameters:
  attributes :id, :employee_work_info, :employee_personal_info
  # include FastJsonapi::ObjectSerializer
  # attributes :id, :email, :role
  #
  # attribute :token, if: proc { |_record, params|
  #   params && params[:include_token]
  # }
  #
  # attribute :token do |_user, params|
  #   params[:token]
  # end
end
