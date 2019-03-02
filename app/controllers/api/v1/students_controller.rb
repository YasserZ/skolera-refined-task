module Api
  module V1
    class StudentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_student, only: [:show, :update, :destroy]

      # GET /students
      def index
        @students = Student.all

        render json: StudentSerializer.new(@students).serialized_json
      end

      # GET /students/1
      def show
        render json: StudentSerializer.new(@student).serialized_json
      end

      # POST /students
      def create
        begin
          @student = Student.new(student_params)

          if @student.save
            render json: StudentSerializer.new(@student).serialized_json, status: :created
          else
            render json: @student.errors, status: :unprocessable_entity
          end
        rescue ActionController::ParameterMissing, ActionController::ArgumentError => e
          render json: {status: 400, error: "Bad Request", body: e.message}, :status => 400

        end
      end

      # PATCH/PUT /students/1
      def update
        begin
          if @student.update(student_params)
            render json: @student
          else
            render json: @student.errors, status: :unprocessable_entity
          end
        rescue ActionController::ParameterMissing, ActionController::ArgumentError => e
          render json: {status: 400, error: "Bad Request", body: e.message}, :status => 400

        end
      end

      # DELETE /students/1
      def destroy
        @student.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_student
        begin
          @student = Student.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: {status: 404, error: "Not Found", body: e.message}, :status => 404

        end
      end

      # Only allow a trusted parameter "white list" through.
      def student_params
        params.require(:student).permit(:name, :email, :phone, :age, :grade)
      end
    end

  end
end