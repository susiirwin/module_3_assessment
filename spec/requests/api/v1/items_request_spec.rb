require 'rails_helper'

describe " api" do
  it "returns a list of items" do
    FactoryGirl.create_list(:item, 2)

    get '/api/v1/items.json'
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(items.count).to eq(2)
  end

  it "returns a single item based on id" do
    item = FactoryGirl.create(:item)

    get "/api/v1/items/#{item.id}.json"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(item["name"]).to eq("Piggy Bank")
  end

  it "deletes the specified item based on id" do
    item = FactoryGirl.create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}.json"

    expect(response).to be_success
    expect(response.status).to eq(204)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(Item.count).to eq(0)
  end

  it "creates a new item with params" do
    item_params = { name: "Kite", description: "It flies!", image_url: "http://www.google.com/images" }

    expect(Item.count).to eq(0)

    post '/api/v1/items.json', params: {item: item_params}
    item = JSON.parse(response.body)

    expect(response.to be_success)
    expect(item.count).to eq(1)
    expect(response.status).to eq(200)
    expect(item.name).to eq(item_params[:name])
  end
end


#
# When I send a GET request to /api/v1/items I receive a 200 JSON response containing all items And each item has an id, name, description, and image_url but not the created_at or updated_at
#
# When I send a GET request to /api/v1/items/1 I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at
#
# When I send a DELETE request to /api/v1/items/1 I receive a 204 JSON response if the record is successfully deleted
#
# CREATE When I send a POST request to /api/v1/items with a name, description, and image_url I receive a 201 JSON response if the record is successfully created And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at
#
# Verify that your API works using Postman or curl
