class Building
  include Mongoid::Document
  field :name, type: String
  field :location, type: String

  has_many :floors, autosave: true

  accepts_nested_attributes_for :floors, allow_destroy: true

  validates :name, :location, presence: true
end
