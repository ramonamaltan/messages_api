class Api::V1::MessagesController < ApplicationController
  before_action :find_message, only: [:show, :update, :destroy]

  def index
    @messages = Message.all
    render json: MessageSerializer.new(@messages).serializable_hash.to_json
  end

  def show
    options = { include: [:links] }
    render json: MessageSerializer.new(@message, options).serializable_hash.to_json
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render json: MessageSerializer.new(@message).serializable_hash.to_json, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      render json: MessageSerializer.new(@message).serializable_hash.to_json, status: :ok
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    head 204
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
