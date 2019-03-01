# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
students = []
teachers = []
courses = []
10.times do
  teacher = Teacher.new({
                            name: Faker::Superhero.name,
                            email: Faker::Internet.email,
                            age: Faker::Number.number(2),
                            phone: Faker::PhoneNumber.phone_number
                        })
  student = Student.new({
                            name: Faker::Superhero.name,
                            email: Faker::Internet.email,
                            age: Faker::Number.number(2),
                            grade: Faker::Number.number(1),
                            phone: Faker::PhoneNumber.phone_number
                        })
  course = Course.new({
                          name: Faker::Book.title,
                          code: Faker::Military.dod_paygrade
                      })
  teachers.push(teacher)
  students.push(student)
  courses.push(course)
  course.teacher = teacher
  course.students = students
  course.save
  teacher.save
  student.save
end