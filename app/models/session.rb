class Session < ActiveRecord::Base
  BOOKABLE = :bookable
  UNAVAILABLE = :unavailable

  belongs_to :person
  has_many :bookings

  def self.upcoming
    where("starts_at > NOW()")
  end

  def state
    if bookings.any?(&:persisted?)
      UNAVAILABLE
    else
      BOOKABLE
    end
  end

  def bookable?
    state == BOOKABLE
  end
end
