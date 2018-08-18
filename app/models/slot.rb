class Slot
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float

  belongs_to :floor

  validates :name, :price, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 0

  def specifics
    "#{floor.try(:building).try(:name)} - #{floor.try(:name)} - #{name} - #{price}/hr"
  end
end
