require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "Message with characters from different languages should be valid" do
    message = Message.new(content: '可口可樂 مرحبا بالعالم Hello é ç à Здравствуйте ?.!')

    assert message.valid?
  end

  test "Message with html tags should be invalid" do
    message = Message.new(content: "<td class='content'>This is an example text</td>")

    assert_not message.valid?
  end

  test "Message shorter than 255 characters should be valid" do
    message = Message.new
    message.content = "a" * 255

    assert message.valid? 
  end

  test "Message longer than 255 characters should be invalid" do
    message = Message.new
    message.content = "a" * 256

    assert_not message.valid? 
  end
end
