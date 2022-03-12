json.status 400 unless params[:password]
if params[:password]
  decrypt_message_path params[:password]
  json.partial! "messages/message", message: @message
end