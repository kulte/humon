class Event < ActiveRecord::Base
  validates :lat, :lng, :name, :started_at, presence: true

  has_many :attendances
  belongs_to :owner, class_name: 'User'

  reverse_geocoded_by :lat, :lng
end
