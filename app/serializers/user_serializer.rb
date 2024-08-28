# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :role

  attribute :token, if: proc { |_record, params|
    params && params[:include_token]
  }

  attribute :token do |_user, params|
    params[:token]
  end
end
