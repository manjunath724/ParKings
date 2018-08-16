class Car
  include Mongoid::Document
  field :registration_number, type: String
  field :model, type: String
  field :color, type: String
  belongs_to :user

  validates :registration_number, :model, :color, presence: true
end
