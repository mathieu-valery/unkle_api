class Api::V1::ContractsController < Api::V1::BaseController
    def index
        @contracts = policy_scope(Contract.all)

        render json: @contracts
    end
end