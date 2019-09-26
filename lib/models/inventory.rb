require_relative 'product'
require_relative 'collection'

class Inventory
  attr_reader :collections

  def initialize(product_data)
    @collections = []
    @products = []

    product_data.each do |record|
      @products << Product.new(@products.length, record["options"])
      collection = find_or_create_collection(record["product_type"])
      collection.add_product(@products.last)
    end
  end

  def product_search(type, options = [])
    collection = find_collection(type)

    raise NameError, "Product type #{type} not found" if collection.nil?

    puts collection.available_options(options)
  end

  private

  def find_or_create_collection(product_type)
    find_collection(product_type) || create_collection(product_type)
  end

  def find_collection(product_type)
    @collections.find { |collection| collection.type == product_type }
  end

  def create_collection(product_type)
    @collections << Collection.new(@collections.length, product_type)
    @collections.last
  end
end
