require 'test_helper'

class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should show all messages" do
    get api_v1_messages_url, as: :json
    assert_response :success
  end

  test "should show message" do
    get api_v1_message_url(@message), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body, symbolize_names: true)
    assert_equal @message.content, json_response.dig(:data, :attributes, :content)
    assert_equal @message.links.first.id.to_s, json_response.dig(:data, :relationships, :links, :data, 0, :id)
    assert_equal @message.links.first.url, json_response.dig(:included, 0, :attributes, :url)
    assert_equal @message.emails.first.id.to_s, json_response.dig(:data, :relationships, :emails, :data, 0, :id)
  end

  test "should create message" do
    assert_difference('Message.count') do
      post  api_v1_messages_url,
            params: { message: { content: "I created this message for testing!" } },
            as: :json
    end
    assert_response :created
  end

  test "should not create message with empty content" do
    assert_no_difference('Message.count') do
      post  api_v1_messages_url,
            params: { message: { content: "" } },
            as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update message" do
    patch api_v1_message_url(@message),
          params: { message: { content: "update this message for testing" } },
          as: :json
    assert_response :success
  end

  test "should not update message with empty content" do
    patch api_v1_message_url(@message),
          params: { message: { content: "" } },
          as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete api_v1_message_url(@message), as: :json
    end
    assert_response :no_content
  end
end
