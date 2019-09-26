require 'byebug'
require_relative 'product'

class Collection
  attr_reader :type, :product_options, :options_index

  def initialize(id, type)
    @id = id
    @type = type
    @option_types = []
    @product_options = {}
    @options_index = {}
  end

  def add_product(product)
    product.collection_id = @id
    add_to_indexes(product)
  end

  def available_options(options = [])
    return 'Invalid option(s) entered' if invalid_options?(options)

    results = find_by_options(options)

    return 'No products found with these options' if results.empty?

    @option_types[options.length..-1].map do |option_type|
      available_options = (@product_options[option_type] & results).join(', ')
      "#{option_type.capitalize}: #{available_options}"
    end
  end

  private

  def invalid_options?(options)
    !(options - @product_options.values.flatten).empty?
  end

  def add_to_indexes(product)
    @option_types = product.options.keys if @option_types.empty?

    product.options.values.each_with_index do |value, index|
      option_type = @option_types[index]

      if @options_index[index].nil?
        @options_index[index] = { value => [product.options.values] }
        @product_options[option_type] = [value]
      elsif @options_index[index].key?(value)
        @options_index[index][value] << product.options.values
      else
        @options_index[index][value] = [product.options.values]
        @product_options[option_type] << value
      end
    end
  end

  def find_by_options(options = [])
    return @product_options.values.flatten if options.empty?

    matches = options.map.with_index { |_, i| @options_index[i][options[i]] || [] }
    matches.inject(:&).flatten.uniq - options
  end
end
