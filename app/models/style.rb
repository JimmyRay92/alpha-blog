class Style < ApplicationRecord
    has_many :teachers_styles, dependent: :delete_all
    has_many :teachers, through: :teachers_styles
end
