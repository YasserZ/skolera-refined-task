class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :code
  belongs_to :teacher, optional: true
  has_many :students
end
