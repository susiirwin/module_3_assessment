class Store
  attr_reader :long_name,
              :city,
              :distance,
              :phone_number,
              :store_type

  def initialize(store)
    # require 'pry'; binding.pry
    @long_name = store[:longName]
    @city = store[:city]
    @distance = store[:distance]
    @phone_number = store[:phone]
    @store_type = store[:storeType]
  end

end
