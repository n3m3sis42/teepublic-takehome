#!/usr/bin/env ruby
require 'json'
require_relative '../lib/models/inventory'
require_relative '../lib/console'

# parse products file
file = File.read('products.json')
product_data = JSON.parse(file)

# build inventory from parsed product data
inventory = Inventory.new(product_data)

# start up console to accept user input
console = Console.new

# query inventory object with inputted product options
inventory.product_search(console.product_type, console.options)
