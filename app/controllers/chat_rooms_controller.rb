class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    @chat_room.user_id = current_user.id
    if @chat_room.save
      current_user.chat_rooms << @chat_room
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    if !current_user.chat_rooms.include?(@chat_room)
      current_user.chat_rooms << @chat_room
      current_user.chat_room_users.last.last_read_message = @chat_room.messages.last.id
    end
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
