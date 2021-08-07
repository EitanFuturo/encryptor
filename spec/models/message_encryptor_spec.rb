require 'rails_helper'

describe MessageEncryptor do

  text = 'Bill'
  password = 'Evans'
  error_message = "Contraseña inválida"

  let(:message) { Message.create(text: text, password: password, confirmed_password: password) }


  it 'returns same input message when decrypted' do
    decrypted_message = subject.decrypt(message.text, password, message.iv) rescue error_message
    expect(decrypted_message).to eq text
  end

  it 'returns invalid password message when password is not correct' do
    decrypted_message = subject.decrypt(message.text, password.reverse, message.iv) rescue error_message
    expect(decrypted_message).to eq error_message
    true
  end
end