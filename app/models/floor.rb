class Floor
  include Mongoid::Document
  field :name, type: String

  belongs_to :building
  has_many :slots, autosave: true

  accepts_nested_attributes_for :slots

  validates :name, presence: true
end
