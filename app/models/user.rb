class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :teacher, dependent: :destroy
  has_many :bookings

  # Validates Full Name for user sign-up
  validates :fullname, presence: true, length: { in: 1...150 }

  # Validates email for User sign-up
  validates :email, presence: true, uniqueness: { case_sensitive: true }, length: { in: 1...75 }

  # Validates password for user sign-up
  validates :password, confirmation: true, presence: true, length: { in: 1...50 }

end
