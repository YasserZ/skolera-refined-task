module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def index
        UserWorker.perform_async
        render json: {message: "successfully added to queue", status: 200}.to_json
      end

    end

  end
end