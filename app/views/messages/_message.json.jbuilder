json.extract! message, :id, :encoded_text, :created_at, :updated_at
json.url message_url(message, format: :json)
