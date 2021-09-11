class MessageMailer < ApplicationMailer
  default from: 'encryptator@gmail.com'

  def share_message
    @message_url = params[:message_url]

    mail(to: params[:recipient], subject: 'Recibiste un nuevo mensaje secreto.')
  end
end
