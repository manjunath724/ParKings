class Floor
  include Mongoid::Document
  field :name, type: String

  belongs_to :building
  has_many :slots, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :slots, allow_destroy: true

  validates :name, presence: true
end
