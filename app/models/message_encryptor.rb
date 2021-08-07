class MessageEncryptor
  attr_accessor :cipher, :encrypted_message, :key, :iv

  def initialize
    @cipher = OpenSSL::Cipher::AES.new(256, :CBC)
  end

  def encrypt(message, password)
    cipher.encrypt
    self.key = Digest::SHA256.digest(password)
    self.iv = cipher.random_iv

    cipher.key = key
    self.encrypted_message = cipher.update(message) + cipher.final
  end

  def decrypt(message, password, iv)
    begin
      cipher.decrypt
      cipher.key = Digest::SHA256.digest(password)
      cipher.iv = iv
      decrypted_message = cipher.update(message) + cipher.final
      decrypted_message.force_encoding('utf-8')
    rescue
      "Contraseña inválida"
    end
  end
end