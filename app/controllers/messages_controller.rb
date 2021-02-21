class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy decrypt_message ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
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
    encrypted_message = encrypt_message(message_params[:text],
                                        message_params[:password])
    iv = encrypted_message[:iv]
    @message = Message.new(text: encrypted_message[:encrypted_message],
                           iv: iv)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: "Copiá el link de tu mensaje: #{message_url(@message)}" }
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
    @message.text = (encryptor.decrypt(@message.text, password, @message.iv) rescue "Bad decrypt").force_encoding('utf-8')

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
      params.require(:message).permit(:text, :password)
    end

    def encrypt_message(message, password)
      encryptor = MessageEncryptor.new
      encryptor.encrypt(message, password)
      { encrypted_message: encryptor.encrypted_message, iv: encryptor.iv }
    end
end
