class Message < ApplicationRecord

  #Association
  belongs_to :chat_room
  belongs_to :user

  #Validation
  validates :content, presence: true, length: {minimum: 2, maximum: 1000}

  #Callback
  after_create_commit { MessageBroadcastJob.perform_later(self) }


  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
