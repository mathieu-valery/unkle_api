class Contract < ApplicationRecord
    has_many :subscriptions, dependent: :destroy
    has_many :users, through: :subscriptions
    has_many :contract_options, dependent: :destroy

    validates :date_start, presence: true
    validates :number, uniqueness: true
    validates_associated :subscriptions
    
end
