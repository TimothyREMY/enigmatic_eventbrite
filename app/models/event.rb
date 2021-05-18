class Event < ApplicationRecord
  has_many :attendances
	has_many :users, through: :attendances
	belongs_to :admin, class_name: "User"

  def is_started
    if (self.start_date) < Time.now
    self.errors[:base] << "Cannot be in the past !"
    end
  end

  def multiple_of_5
    if (self.duration % 5) != 0
    self.errors[:base] << "Number must be divisible by 5!"
    end
  end

  
  validate :is_started, :multiple_of_5
  validates :start_date, :duration, :title, :description, :price, :location, presence: true
  validates :title, length: { in: 5..140}
  validates :description, length: { in: 20..1000}
  validates :price, presence: true, numericality: {greater_than: 1, less_than: 1000}
end
