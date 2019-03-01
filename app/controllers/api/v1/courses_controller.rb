module Api
  module V1
    class CoursesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_course, only: [:show, :update, :destroy, :add_student, :remove_student, :assign_teacher, :remove_teacher]

      # GET /courses
      def index
        @courses = Course.all

        render json: CourseSerializer.new(@courses).serialized_json
      end

      # GET /courses/1
      def show
        render json: CourseSerializer.new(@course).serialized_json
      end

      # POST /courses
      def create
        @course = Course.new(course_params)
        if @course.save
          render json: CourseSerializer.new(@course).serialized_json, status: :created
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /courses/1
      def update
        if @course.update(course_params)
          render json: CourseSerializer.new(@course).serialized_json
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      # DELETE /courses/1
      def destroy
        @course.destroy
      end

      def add_student
        student = Student.find(params[:student_id])
        if @course.students.include?(student)
          return render json: {message: "student already enrolled in course", course_data: CourseSerializer.new(@course)}.to_json
        end
        @course.students.push(student)
        @course.save
        render json: {message: "student enrolled successfully", course_data: CourseSerializer.new(@course)}.to_json
      end

      def remove_student
        student = Student.find(params[:student_id])
        if @course.students.include?(student)
          @course.students.delete(student)
          @course.save
          return render json: {message: "student removed from course", course_data: CourseSerializer.new(@course)}.to_json
        end
        render json: {message: "student already not enrolled in course", course_data: CourseSerializer.new(@course)}.to_json
      end

      def assign_teacher
        teacher = Teacher.find(params[:teacher_id])
        @course.teacher = teacher
        @course.save
        render json: {message: "teacher successfully assigned to course", course_data: CourseSerializer.new(@course)}.to_json

      end

      def remove_teacher
        teacher = Teacher.find(params[:teacher_id])
        if @course.teacher == teacher
          @course.teacher = nil
          @course.save
          return render json: {message: "teacher successfully removed from course", course_data: CourseSerializer.new(@course)}.to_json
        end
        render json: {message: "teacher was not enrolled in this course", course_data: CourseSerializer.new(@course)}.to_json
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_course
        @course = Course.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def course_params
        params.require(:course).permit(:name, :code, :teacher_id)
      end
    end

  end
end