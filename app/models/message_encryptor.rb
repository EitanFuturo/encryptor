class MessageEncryptor
  attr_reader :encrypted_message, :key

  def initialize(message)
    @encrypted_message = encrypt(message)
  end

  private

    def encrypt(message)
      @key = "llave"
      "mensaje encriptado."
    end
end