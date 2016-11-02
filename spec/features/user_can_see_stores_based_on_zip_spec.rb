require 'rails_helper'

RSpec.feature 'Search for stores with Zip' do
  scenario 'returns a list of stores' do
    VCR.use_cassette("#getstores") do

      # As a user
      # When I visit "/"
      visit '/'
      # And I fill in a search box with "80202" and click "search"
      fill_in "search_index", with: "80202"

      click_on "Search"
      # Then my current path should be "/search" (ignoring params)
      expect(current_path).to eq('/search')
      # And I should see stores within 25 miles of 80202

      # And I should see a message that says "17 Total Stores"
      expect(page).to have_content("17 Total Stores")
      # And I should see exactly 15 results
      expect(page).to have_selector('.fullname', count: 15)
      # And I should see the long name, city, distance, phone number and store type for each of the 15 results (so this is an iteration over the array in a bulleted list)
      within first ".store" do
        find('.fullname').text.should match("Best Buy Mobile - Cherry Creek Shopping Center")
      end

      expect(page).to have_content("Name:")
      expect(page).to have_content("City:")
      expect(page).to have_content("Distance:")
      expect(page).to have_content("Phone Number:")
      expect(page).to have_content("Store Type:")


    end
  end
end
