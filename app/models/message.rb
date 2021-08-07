class Message < ApplicationRecord
  attr_accessor :password, :confirmed_password

  validate :confirm_passwords
  before_save :encrypt_message

  def encoded_text
    return "<i>[Texto cifado]</i>".html_safe if text.encoding == Encoding::ASCII_8BIT
    text.force_encoding('utf-8')
  end

  private

  def confirm_passwords
    errors.add(:confirmed_password, "Las contraseñas no coinciden.") if password != confirmed_password
  end

  def encrypt_message
    encryptor = MessageEncryptor.new
    encryptor.encrypt(text, password)
    self.text = encryptor.encrypted_message
    self.iv = encryptor.iv
  end
end
