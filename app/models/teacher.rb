class Teacher < ApplicationRecord
  has_many :courses, dependent: :nullify
end
