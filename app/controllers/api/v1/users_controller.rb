class Api::V1::UsersController < Api::V1::BaseController
    def index
        @users = policy_scope(User.all)

        render json: @users
    end
end
