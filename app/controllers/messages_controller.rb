class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy decrypt_message ]

  # GET /messages or /messages.json
  def index
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(text: message_params[:text], password: message_params[:password],
                           confirmed_password: message_params[:confirmed_password])

    respond_to do |format|
      if @message.save
        send_email(message_params[:email_recipient]) if message_params[:email_recipient]

        format.html { redirect_to @message, notice: "#{message_url(@message)}" }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def decrypt_message
    password = params[:password]
    encryptor = MessageEncryptor.new
    @message.text = encryptor.decrypt(@message.text, password, @message.iv).force_encoding('utf-8')

    respond_to do | format |
      format.turbo_stream { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:text, :password, :confirmed_password, :email_recipient)
    end

    def send_email(recipient)

    end
end
