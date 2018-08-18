class ParkingRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUSES = {
    requested: 'Slot Requested',
    allotted: 'Slot Allotted',
    release: 'Slot Release Requested',
    discharged: 'Slot Discharged'
  }.freeze

  field :status, type: String
  field :entry_on, type: Time
  field :exit_on, type: Time
  field :total_time, type: String
  field :amount, type: Float

  belongs_to :car
  belongs_to :slot, optional: true

  validates :car_id, :status, presence: true

  before_update :set_discharge_specifics

  STATUSES.keys.each do |k|
    scope k.to_sym, -> { where(status: STATUSES[k]) }
  end

  STATUSES.each do |k, v|
    define_method("#{k}?") do
      status == v
    end
  end

  private

  def set_discharge_specifics
    return unless self.discharged?
    exit_time = Time.now
    diff = (exit_time - self.entry_on).round.abs
    total_time = Time.at(diff).utc.strftime "%H h : %M min"
    hours = diff / (60 * 60)
    hours += 1 unless ((diff / 60) % 60).zero?
    amount = self.slot.price * hours
    self.exit_on = exit_time
    self.total_time = total_time
    self.amount = amount
  end
end
