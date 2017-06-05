class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
  end

  def read_message(data)
    blah = current_user.chat_room_users.where(chat_room_id: data['chat_room_id']).first
    blah.last_read_message = data['message_id']
    blah.save
  end
end
