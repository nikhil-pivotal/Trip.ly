class Itinerary < ApplicationRecord
  belongs_to :trip

  has_many :events, dependent: :destroy
end
