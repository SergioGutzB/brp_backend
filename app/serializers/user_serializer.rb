class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :role

  attribute :token, if: Proc.new { |record, params|
    params && params[:include_token]
  }

  attribute :token do |user, params|
    params[:token]
  end
end
