class MessagesController < ApplicationController
  def unread
    @chat_rooms = current_user.chat_rooms.select {|l| l.messages.last.id > l.chat_room_users.first.last_read_message}
  end
end
