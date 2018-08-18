require 'test_helper'

class ParkingRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking_request = parking_requests(:one)
  end

  test "should get index" do
    get parking_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_parking_request_url
    assert_response :success
  end

  test "should create parking_request" do
    assert_difference('ParkingRequest.count') do
      post parking_requests_url, params: { parking_request: { amount: @parking_request.amount, car_id: @parking_request.car_id, entry_on: @parking_request.entry_on, exit_on: @parking_request.exit_on, status: @parking_request.status, total_time: @parking_request.total_time } }
    end

    assert_redirected_to parking_request_url(ParkingRequest.last)
  end

  test "should show parking_request" do
    get parking_request_url(@parking_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_parking_request_url(@parking_request)
    assert_response :success
  end

  test "should update parking_request" do
    patch parking_request_url(@parking_request), params: { parking_request: { amount: @parking_request.amount, car_id: @parking_request.car_id, entry_on: @parking_request.entry_on, exit_on: @parking_request.exit_on, status: @parking_request.status, total_time: @parking_request.total_time } }
    assert_redirected_to parking_request_url(@parking_request)
  end

  test "should destroy parking_request" do
    assert_difference('ParkingRequest.count', -1) do
      delete parking_request_url(@parking_request)
    end

    assert_redirected_to parking_requests_url
  end
end
