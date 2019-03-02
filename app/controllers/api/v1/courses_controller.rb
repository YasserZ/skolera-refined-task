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
        begin
          @course = Course.new(course_params)
          if @course.save
            render json: CourseSerializer.new(@course).serialized_json, status: :created
          else
            render json: @course.errors, status: :unprocessable_entity
          end

        rescue ActionController::ParameterMissing, ActionController::ArgumentError => e
          render json: {message: "Error!", body: e.message}, :status => 400
        end
      end

      # PATCH/PUT /courses/1
      def update
        begin
          if @course.update(course_params)
            render json: CourseSerializer.new(@course).serialized_json
          else
            render json: @course.errors, status: :unprocessable_entity
          end
        rescue ActionController::ParameterMissing, ActionController::ArgumentError => e
          render json: {message: "Error!", body: e.message}, :status => 400

        end
      end

      # DELETE /courses/1
      def destroy
        @course.destroy
      end

      def add_student
        begin
          unless params[:student_id]
            return render json: {status: 400, error: "Bad Request", body: "No student specified!"}, :status => 400
          end
          student = Student.find(params[:student_id])
          if @course.students.include?(student)
            return render json: {status: 200, message: "student already enrolled in course", course_data: CourseSerializer.new(@course)}.to_json
          end
          @course.students.push(student)
          @course.save
          render json: {status: 200, message: "student enrolled successfully", course_data: CourseSerializer.new(@course)}.to_json
        rescue ActiveRecord::RecordNotFound => e
          render json: {status: 404, error: "Not Found", body: e.message}, :status => 404
        end
      end

      def remove_student
        begin
          unless params[:student_id]
            return render json: {status: 400, error: "Bad Request", body: "No student specified!"}, :status => 400
          end
          student = Student.find(params[:student_id])
          if @course.students.include?(student)
            @course.students.delete(student)
            @course.save
            return render json: {status: 200, message: "student removed from course", course_data: CourseSerializer.new(@course)}.to_json
          end
          render json: {status: 404, error: "Not Found", body: "student was not enrolled in this course"}, :status => 404
        rescue ActiveRecord::RecordNotFound => e
          render json: {status: 404, error: "Not Found", body: e.message}, :status => 404

        end
      end

      def assign_teacher
        begin
          unless params[:teacher_id]
            return render json: {status: 400, error: "Bad Request", body: "No teacher specified!"}, :status => 400
          end

          teacher = Teacher.find(params[:teacher_id])
          @course.teacher = teacher
          @course.save
          render json: {status: 200, message: "teacher successfully assigned to course", course_data: CourseSerializer.new(@course)}.to_json
        rescue ActiveRecord::RecordNotFound => e
          render json: {status: 404, error: "Not Found", body: e.message}, :status => 404

        end

      end

      def remove_teacher
        begin
          unless params[:teacher_id]
            return render json: {status: 400, error: "Bad Request", body: "No teacher specified!"}, :status => 400
          end
          teacher = Teacher.find(params[:teacher_id])
          if @course.teacher == teacher
            @course.teacher = nil
            @course.save
            return render json: {message: "teacher successfully removed from course", course_data: CourseSerializer.new(@course)}.to_json
          end
          render json: {status: 404, error: "Not Found", body: "teacher was not enrolled in this course"}, :status => 404
        rescue ActiveRecord::RecordNotFound => e
          render json: {status: 404, error: "Not Found", body: e.message}, :status => 404

        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_course
        begin
          @course = Course.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: {status: 404, error: "Not Found", body: e.message}, :status => 404
        end
      end

      # Only allow a trusted parameter "white list" through.
      def course_params
        params.require(:course).permit(:name, :code, :teacher_id)
      end
    end

  end
end