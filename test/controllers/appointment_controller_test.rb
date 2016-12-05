require 'test_helper'

class AppointmentControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get appointment_news_url
    assert_response :success
  end

  test "should get create" do
    get appointment_create_url
    assert_response :success
  end

  test "should get edit" do
    get appointment_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get appointment_destroy_url
    assert_response :success
  end

end
