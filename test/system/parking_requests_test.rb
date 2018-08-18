require "application_system_test_case"

class ParkingRequestsTest < ApplicationSystemTestCase
  setup do
    @parking_request = parking_requests(:one)
  end

  test "visiting the index" do
    visit parking_requests_url
    assert_selector "h1", text: "Parking Requests"
  end

  test "creating a Parking request" do
    visit parking_requests_url
    click_on "New Parking Request"

    fill_in "Amount", with: @parking_request.amount
    fill_in "Car", with: @parking_request.car_id
    fill_in "Entry On", with: @parking_request.entry_on
    fill_in "Exit On", with: @parking_request.exit_on
    fill_in "Status", with: @parking_request.status
    fill_in "Total Minutes", with: @parking_request.total_time
    click_on "Create Parking request"

    assert_text "Parking request was successfully created"
    click_on "Back"
  end

  test "updating a Parking request" do
    visit parking_requests_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @parking_request.amount
    fill_in "Car", with: @parking_request.car_id
    fill_in "Entry On", with: @parking_request.entry_on
    fill_in "Exit On", with: @parking_request.exit_on
    fill_in "Status", with: @parking_request.status
    fill_in "Total Minutes", with: @parking_request.total_time
    click_on "Update Parking request"

    assert_text "Parking request was successfully updated"
    click_on "Back"
  end

  test "destroying a Parking request" do
    visit parking_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Parking request was successfully destroyed"
  end
end
