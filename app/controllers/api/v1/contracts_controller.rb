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

        #VERIFIER SI USERS ET OPTIONS DANS LES PARAMS EXISTENT DANS LA BD ET QUE LES PARAMS NE SONT PAS VIDES
        @users_found = User.where(email: clients_params[:emails]).to_a
        @options_found = Option.where(name: options_params[:names]).to_a

        if @users_found.length != clients_params[:emails].to_a.length
            render json: {
                messages: "User does not exist",
            }, status: :bad_request
            return
        end

        if @users_found.length == 0
            render json: {
                messages: "You must provide a user",
            }, status: :bad_request
            return
        end

        if @options_found.length != options_params[:names].to_a.length
        render json: {
            messages: "Option does not exist",
        }, status: :bad_request
            return
        end

        if @options_found.length == 0
            render json: {
                messages: "You must provide an option",
            }, status: :bad_request
            return
        end        
       
        if @contract.save! #Save contract
        
            @users_found.each do |user| #post request users params
                subscription = Subscription.new(user_id: user.id, contract_id: @contract.id)
                @subscriptions << subscription
                
            end

            @options_found.each do |option| #post request contracts params
                contract_option = ContractOption.new(option_id: option.id, contract_id: @contract.id)
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

    def clients_params
        params.require(:clients).permit(emails: [])
    end

    def options_params
        params.require(:options).permit(names: [])
    end

    def render_error
        render json: { errors: @contract.errors.full_messages },
          status: :unprocessable_entity
    end
end