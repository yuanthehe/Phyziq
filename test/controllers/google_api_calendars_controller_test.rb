require 'test_helper'

class GoogleApiCalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get redirect" do
    get google_api_calendars_redirect_url
    assert_response :success
  end

  test "should get callback" do
    get google_api_calendars_callback_url
    assert_response :success
  end

  test "should get calendars" do
    get google_api_calendars_calendars_url
    assert_response :success
  end

end
