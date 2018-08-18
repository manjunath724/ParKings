class Slot
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float

  belongs_to :floor

  validates :name, :price, presence: true

  def specifics
    "#{floor.building.name} - #{floor.name} - #{name} - #{price}/hr"
  end
end
