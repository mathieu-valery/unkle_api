class Api::V1::ContractsController < Api::V1::BaseController
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!

    def index
        if current_user.admin?
            @contracts = policy_scope(Contract.all)
        else
            @contracts = policy_scope(current_user.contracts)

        end    
        render json: @contracts
    end

    def create
        @contract = Contract.new(contract_params)
        authorize @contract #check if user is admin (see policies)
        @subscriptions = []
        @contract_options = []

        @users_ids = User.all.ids
        @options_ids = Option.all.ids

        #VERIFIER SI USERS ID ET OPTIONS ID DANS LES PARAMS EXISTENT DANS LA BD
        if users_params[:users_id].all? {|i| @users_ids.exclude?(i)}
            render json: {
                messages: "User does not exist",
            }, status: :bad_request
            return
        end

        if options_params[:options_id].all? {|i| @options_ids.exclude?(i)}
        render json: {
            messages: "Option does not exist",
        }, status: :bad_request
            return
        end
    
        if @contract.save! #Save contract
        
            users_params[:users_id].each do |user_id| #post request users params
                subscription = Subscription.new(user_id: user_id, contract_id: @contract.id)
                @subscriptions << subscription
                
            end

            options_params[:options_id].each do |option_id| #post request contracts params
                contract_option = ContractOption.new(option_id: option_id, contract_id: @contract.id)
                @contract_options << contract_option
            end
    
        @subscriptions.each(&:save!)
        @contract_options.each(&:save!)

            render json: {
                messages: "Contract created successfully",
                is_success: true,
                data: {contract: @contract}
                }, status: :ok
            return
        else
            render_error
        end
      end

    private

    def contract_params
        params.require(:contract).permit(:number, :status, :date_start, :date_end)
    end

    def users_params
        params.require(:clients).permit(users_id: [])
    end

    def options_params
        params.require(:options).permit(options_id: [])
    end

    def render_error
        render json: { errors: @contract.errors.full_messages },
          status: :unprocessable_entity
    end
end