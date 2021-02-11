require 'test_helper'

class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should show message" do
    get api_v1_message_url(@message), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @message.content, json_response['content']
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
end
