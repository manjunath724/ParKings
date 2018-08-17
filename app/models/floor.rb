class Floor
  include Mongoid::Document
  field :name, type: String

  embedded_in :building
  embeds_many :slots, cascade_callbacks: true

  accepts_nested_attributes_for :slots, allow_destroy: true, autosave: true

  validates :name, presence: true
end
