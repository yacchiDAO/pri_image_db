class Admin < ApplicationRecord
  validates :login_id, presence: true, uniqueness: true
  has_secure_password validations: false, raise: false
end
