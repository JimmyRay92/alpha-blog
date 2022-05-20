class Teacher < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :teachers_styles, dependent: :delete_all
  has_many :styles, through: :teachers_styles
  has_one_attached :picture

  #  Validations for availability attribute
  validates :availability, presence: true, length: { in: 1...300 }

  # Validations for price attribute
  validates :price, presence: true, length: { in: 1...300 }, numericality: { only_integer: true }

  # Validations for lesson_length attribute
  validates :lesson_length, numericality: { only_integer: true }
  
  # Validations for bio attribute
  validates :bio, :teaching_info, presence: true, length: { in: 1...4000 }
  
  # Validations for picture attribute
  validates :picture, presence: true

end
