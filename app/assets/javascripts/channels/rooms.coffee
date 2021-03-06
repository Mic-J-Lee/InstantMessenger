jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0

    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    messages_to_bottom()
 
    App.global_chat = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel"
        chat_room_id: messages.data('chat-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server
 
      disconnected: ->
        # Called when the subscription has been terminated by the server
 
      received: (data) ->
        messages.append data['message']
        messages_to_bottom()
        @perform 'read_message', message_id: data['message_id'], chat_room_id: data['chat_room_id']
 
      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id


      $('#new_message').submit (e) ->
        $this = $(this)
        textarea = $this.find('#message_body')
        if $.trim(textarea.val()).length > 0
          App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
          textarea.val('')
        e.preventDefault()
        return false
      $("#new_message").keyup (event) ->
        if(event.keyCode == 13)
            $("#submit_message_button").click()
 
      window.onpagehide = -> 
        if $('#submit_message_button').length > 0
          App.global_chat.unsubscribe()
          return null
      $(document).on("page:before-change turbolinks:before-visit", (e) ->
        if $('#submit_message_button').length > 0
          return App.global_chat.unsubscribe())


     

