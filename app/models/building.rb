class Building
  include Mongoid::Document
  field :name, type: String
  field :location, type: String

  embeds_many :floors, cascade_callbacks: true

  accepts_nested_attributes_for :floors, allow_destroy: true, autosave: true

  validates :name, :location, presence: true
end
