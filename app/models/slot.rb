class Slot
  include Mongoid::Document
  field :name, type: String

  embedded_in :floor

  validates :name, presence: true
end
