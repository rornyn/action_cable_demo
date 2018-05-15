class Message < ApplicationRecord

  #Association
  belongs_to :chat_room
  belongs_to :user

  #default per page
  paginates_per 8


  #Validation
  validates :content, presence: true, length: {minimum: 1, maximum: 1000}

  #Deligate
   delegate :name, prefix: :sender,  to: :user

  #Callback
  after_create_commit { MessageBroadcastJob.perform_later(self) }


  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
