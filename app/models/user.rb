class User < ApplicationRecord
  include Password::Validator

  has_secure_password

  validates :name, presence: true
end
