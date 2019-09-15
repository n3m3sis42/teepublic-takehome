require 'models/inventory'

RSpec.describe Inventory, '#hello' do
  context 'for a new project' do
    it 'greets the world' do
      inventory = Inventory.new
      expect(inventory.hello).to eq 'Hello, world!'
    end
  end
end
