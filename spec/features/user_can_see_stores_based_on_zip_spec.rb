require 'rails_helper'

RSpec.feature 'Search for stores with Zip' do
  scenario 'returns a list of stores' do
    VCR.use_cassette("#getstores") do

      visit '/'

      fill_in "search_index", with: "80202"

      click_on "Search"

      expect(current_path).to eq('/search')

      expect(page).to have_content("17 Total Stores")

      expect(page).to have_selector('.fullname', count: 15)

      expect(page).to have_content("Name: Best Buy Mobile - Cherry Creek Shopping Center")
      expect(page).to have_content("Distance: 3.25")
      expect(page).to have_content("City: Denver")
      expect(page).to have_content("Phone: 303-270-9189")
      expect(page).to have_content("Store Type: Mobile")

    end
  end
end
