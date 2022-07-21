# == Schema Information
#
# Table name: admins
#
#  id              :bigint           not null, primary key
#  password_digest :string           not null
#  login_id        :string           not null
#
class Admin < ApplicationRecord
  validates :login_id, presence: true, uniqueness: true
  has_secure_password validations: false
end
