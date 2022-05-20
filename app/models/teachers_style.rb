class TeachersStyle < ApplicationRecord
  belongs_to :teacher
  belongs_to :style

  # Validation for speciality attribute to exist
  validates :teacher_id, :style_id, presence: true
  validates_uniqueness_of :speciality , conditions: -> { where(speciality: true) }, scope: :teacher_id
end
