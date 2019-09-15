require 'byebug'
require_relative 'product'
require_relative 'collection'

class Inventory
  attr_reader :collections

  def initialize(product_data)
    @collections = []

    product_data.each do |record|
      collection = find_or_create_collection(record["product_type"])
      collection.products << Product.new(record["options"])
    end
  end

  def product_search(type, options)
    collection = find_collection(type)

    raise NameError, "Product type #{type} not found!" if collection.nil?

    collection.find_products(options)
  end

  private

  def find_or_create_collection(product_type)
    find_collection(product_type) || create_collection(product_type)
  end

  def find_collection(product_type)
    @collections.find { |collection| collection.type == product_type }
  end

  def create_collection(product_type)
    @collections << Collection.new(product_type)
    @collections.last
  end

  def format_search_results

  end

  # collections is the db and this model can also hold the queries
end
