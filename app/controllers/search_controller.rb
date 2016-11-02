class SearchController < ApplicationController
  def index
    result = Faraday.get("https://api.bestbuy.com/v1/stores(area(80202,25))?format=json&show=storeId,storeType,name,phone,distance,longName,city&pageSize=15&apiKey=uf3hrj9pa5u2jxvqa3xfq5a5")
    raw_results = JSON.parse(result.body, symbolize_names: true)[:stores]
# require 'pry'; binding.pry
    @results = raw_results.map do |store|
      Store.new(store)
    end
  end

end
