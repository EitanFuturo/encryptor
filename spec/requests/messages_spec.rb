require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  it "should create message when passwords match" do
    expect do
      post :create, params: { message: { text: 'test', password: 'password', confirmed_password: 'password' } }
    end.to change { Message.count }.by(1)
  end

  it "should not create message when passwords don't match" do
    expect do
      post :create, params: { message: { text: 'test', password: 'password1', confirmed_password: 'password2' } }
    end.to_not change { Message.count }
  end

  it "send email when recipient address provided" do
    expect do
      post :create, params: { message: { text: 'test', password: 'password', confirmed_password: 'password', email_recipient: 'test@test.com' } }
    end.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
