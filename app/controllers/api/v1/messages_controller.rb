class Api::V1::MessagesController < ApplicationController
  def show
    render json: Message.find(params[:id])
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      render json: @message, status: :ok
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    head 204
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
