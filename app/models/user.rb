class User < ApplicationRecord
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
  has_many :attendances, foreign_key: 'participant_id'
  has_many :events, through: :attendances

  has_many :organisers, foreign_key: 'admin_id', class_name: "Event"
end
