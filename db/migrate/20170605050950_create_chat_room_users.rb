class CreateChatRoomUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_room_users do |t|
      t.integer :user_id
      t.integer :chat_room_id
    end
  end
end
