class Stop < ApplicationRecord
  after_create :set_hour, if: Proc.new{|s| s.route.stops.count > 1}

  belongs_to :route

  validates :hour_arrival, :load, :latitude, :longitude, presence: true

  def set_hour
    hour_start = self.route.stops.collect(&:hour_arrival).min
    hour_end = self.route.stops.collect(&:hour_arrival).max
    self.route.update(hour_start: hour_start, hour_end: hour_end)
  end
end
