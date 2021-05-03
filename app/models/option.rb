class Option < ApplicationRecord
    has_many :contract_options

    validates :name, uniqueness: true
end
