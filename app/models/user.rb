class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :validatable
end
