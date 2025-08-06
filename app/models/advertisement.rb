class Advertisement < ApplicationRecord
    has_many :advertisement_analytics, foreign_key: "advertisement_id", dependent: :destroy
end
