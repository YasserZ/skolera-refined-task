class StudentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :phone, :age, :grade
  has_many :courses
end
