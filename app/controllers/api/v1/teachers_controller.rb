module Api
  module V1
    class TeachersController < ApplicationController
      before_action :authenticate_user!
      before_action :set_teacher, only: [:show, :update, :destroy]

      # GET /teachers
      def index
        @teachers = Teacher.all
        render json: TeacherSerializer.new(@teachers).serialized_json
      end

      # GET /teachers/1
      def show
        render json: TeacherSerializer.new(@teacher).serialized_json
        # render json: @teacher
      end

      # POST /teachers
      def create
        @teacher = Teacher.new(teacher_params)

        if @teacher.save
          render json: TeacherSerializer.new(@teacher).serialized_json, status: :created
        else
          render json: @teacher.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /teachers/1
      def update
        if @teacher.update(teacher_params)
          render json: TeacherSerializer.new(@teacher).serialized_json
        else
          render json: @teacher.errors, status: :unprocessable_entity
        end
      end

      # DELETE /teachers/1
      def destroy
        @teacher.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_teacher
        @teacher = Teacher.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def teacher_params
        params.require(:teacher).permit(:name, :email, :phone, :age)
      end
    end

  end
end