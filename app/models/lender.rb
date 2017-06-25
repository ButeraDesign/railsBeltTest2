class Lender < ApplicationRecord
  has_secure_password
  has_many :histories

end
