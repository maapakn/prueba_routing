require "application_system_test_case"

class StopsTest < ApplicationSystemTestCase
  setup do
    @stop = stops(:one)
  end

  test "visiting the index" do
    visit stops_url
    assert_selector "h1", text: "Stops"
  end

  test "creating a Stop" do
    visit stops_url
    click_on "New Stop"

    fill_in "Hour Arrival", with: @stop.hour_arrival
    fill_in "Latitude", with: @stop.latitude
    fill_in "Load", with: @stop.load
    fill_in "Longitude", with: @stop.longitude
    fill_in "Route", with: @stop.route_id
    click_on "Create Stop"

    assert_text "Stop was successfully created"
    click_on "Back"
  end

  test "updating a Stop" do
    visit stops_url
    click_on "Edit", match: :first

    fill_in "Hour Arrival", with: @stop.hour_arrival
    fill_in "Latitude", with: @stop.latitude
    fill_in "Load", with: @stop.load
    fill_in "Longitude", with: @stop.longitude
    fill_in "Route", with: @stop.route_id
    click_on "Update Stop"

    assert_text "Stop was successfully updated"
    click_on "Back"
  end

  test "destroying a Stop" do
    visit stops_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stop was successfully destroyed"
  end
end
