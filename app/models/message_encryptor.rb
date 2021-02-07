class MessageEncryptor
  attr_reader :encrypted_message, :key, :iv

  def initialize(key=nil)
    @cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    @iv = "\x80/\xA3Hh\xBB\x97\x84%\x8A0\xB6s\x19\xAA\xCB"
    @key = key || @cipher.random_key
  end

  def encrypt(message)
    @cipher.encrypt
    encrypted_message = @cipher.update(message) + @cipher.final
    @encrypted_message = Base64.encode64(encrypted_message).encode('utf-8')
  end

  def decrypt(message)
    @decipher.decrypt
    @decipher.key = @key
    @decipher.iv = @iv
    plain = decipher.update(message) + decipher.final
    Base64.decode64(message).encode('ascii-8bit')
  end
end