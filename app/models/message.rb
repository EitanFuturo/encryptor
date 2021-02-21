class Message < ApplicationRecord
  attr_accessor :password

  def encoded_text
    return "<i>[Texto cifado]</i>".html_safe if text.encoding == Encoding::ASCII_8BIT
    text.force_encoding('utf-8')
  end
end
