class Car
  include Mongoid::Document
  field :registration_number, type: String
  field :model, type: String
  field :color, type: String
  belongs_to :user
  has_many :parking_requests, dependent: :destroy

  validates :registration_number, :model, :color, presence: true
  validates_uniqueness_of :registration_number

  def identity
    "#{color} - #{model} - #{registration_number}"
  end
end
