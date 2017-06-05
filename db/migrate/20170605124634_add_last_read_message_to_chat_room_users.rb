class AddLastReadMessageToChatRoomUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_room_users, :last_read_message, :integer
  end
end
