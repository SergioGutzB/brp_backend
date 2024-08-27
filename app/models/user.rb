class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: { admin: 0, executive: 1, employee: 2 }

  has_one :admin_profile
  has_one :executive_profile
  has_one :employee_profile
end
