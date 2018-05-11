class Message < ApplicationRecord

  #Association
  belongs_to :chatroom
  belongs_to :user
end
