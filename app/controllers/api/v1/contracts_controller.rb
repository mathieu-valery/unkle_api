class Api::V1::ContractsController < Api::V1::BaseController
    acts_as_token_authentication_handler_for User

    def index
        if current_user.admin
            @contracts = policy_scope(Contract.all)
        else
            @contracts = policy_scope(current_user.contracts)

        end    
        render json: @contracts
    end
end