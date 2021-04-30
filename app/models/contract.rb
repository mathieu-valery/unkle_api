class Contract < ApplicationRecord
    has_many :subscriptions
    has_many :contract_options

    validates :date_start, presence: true
    validates_associated :subscriptions
    
end
