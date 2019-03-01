class TeacherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :phone, :age
  has_many :courses, dependent: :nullify
end
