require 'rails_helper'

describe " api" do
  it "returns a list of items" do
    FactoryGirl.create_list(:item, 2)

    get '/api/v1/items.json'
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it "returns a single item based on id" do
    item = FactoryGirl.create(:item)

    get '/api/v1/items.json'
  end
end


#
# When I send a GET request to /api/v1/items I receive a 200 JSON response containing all items And each item has an id, name, description, and image_url but not the created_at or updated_at
#
# When I send a GET request to /api/v1/items/1 I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at
#
# When I send a DELETE request to /api/v1/items/1 I receive a 204 JSON response if the record is successfully deleted
#
# When I send a POST request to /api/v1/items with a name, description, and image_url I receive a 201 JSON response if the record is successfully created And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at
#
# Verify that your API works using Postman or curl
