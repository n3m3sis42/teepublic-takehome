require 'json'
require_relative '../../lib/models/inventory'
require_relative '../../lib/models/collection'
require_relative '../../lib/models/product'

RSpec.describe Collection do
  before(:all) do
    file = File.read('spec/test_data.json')
    product_data = JSON.parse(file)
    @inventory = Inventory.new(product_data)
  end

  describe '#add_product' do
    let!(:collection) { Collection.new(5, 'jeans') }
    let(:product) { Product.new(16, { 'gender' => 'female', 'size' => '2', 'wash' => 'acid' }) }

    subject { collection.add_product(product) }

    it 'sets the collection_id for the product' do
      subject
      expect(product.collection_id).to eq(5)
    end

    it 'adds the options associated with the product into the options index' do
      subject
      expect(collection.options_index.values).to include({ 'female' => [['female', '2', 'acid']] })
    end

    it 'updates the dictionary of possible product options for the collection' do
      subject
      expect(collection.product_options['gender']).to eq(['female'])
      expect(collection.product_options['size']).to eq(['2'])
      expect(collection.product_options['wash']).to eq(['acid'])
    end
  end

  describe '#available_options' do
    let(:collection) { @inventory.collections[0] }
    let(:options) { [] }
    let(:result1) { ['Gender: male, female', 'Size: 32, 30, 34, 10, 6, 4', 'Wash: dark, acid'] }
    let(:result2) { ['Size: 32, 30, 34', 'Wash: dark'] }
    let(:result3) { ['Wash: dark'] }
    let(:invalid_option_message) { 'Invalid option(s) entered' }
    let(:no_products_found_message) { 'No products found with these options' }

    subject { collection.available_options(options) }

    context 'when no options are passed' do
      it 'returns all available options within the collection' do
        expect(subject).to eq(result1)
      end
    end

    context 'when valid options are passed' do
      context 'with a single inputted option' do
        let(:options) { ['male'] }

        it { is_expected.to eq(result2) }
      end

      context 'with multiple inputted options' do
        let(:options) { ['male', '30'] }

        it { is_expected.to eq(result3) }
      end
    end

    context 'with invalid options' do
      let(:options) { ['invalid'] }

      it { is_expected.to eq(invalid_option_message) }
    end

    context 'with valid options in the wrong order' do
      let(:options) { ['male', 'dark'] }

      it { is_expected.to eq(no_products_found_message) }
    end
  end
end
