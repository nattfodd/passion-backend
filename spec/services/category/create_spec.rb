# frozen_string_literal: true

RSpec.describe Category::Create do
  subject(:create_category) { described_class.new(params).call }

  let(:vertical) { create(:vertical) }
  let(:vertical_id) { vertical.id }
  let(:category_name) { build(:category).name }
  let(:params) { { 'name' => category_name, 'vertical_id' => vertical_id }.with_indifferent_access }

  it 'creates new category' do
    expect { create_category }.to change(Category, :count).by(1)
  end

  it 'returns a ServiceResponse object' do
    expect(create_category).to be_a(ServiceResponse)
  end

  it 'returns response with Category' do
    expect(create_category.response).to be_a(Category)
  end

  it 'returns a valid category object' do
    expect(create_category.response.attributes.slice('name', 'vertical_id')).to eq(params)
  end

  context 'when built-in validation fails' do
    let(:vertical_id) { -1 }

    it 'returns hash with errors' do
      expect(create_category.errors).to eq(['Vertical must exist'])
    end
  end

  it 'sends notification' do
    expect(MessageBroker)
      .to receive_message_chain(:new, :call).with(instance_of(String)).with(no_args)
    create_category
  end

  context 'when the name is already taken by category' do
    let!(:existing_category) { create(:category, name: category_name) }

    it 'returns hash with errors' do
      expect(create_category.errors).to eq(["name #{category_name} is already taken"])
    end
  end

  context 'when the name is already taken by vertical' do
    let!(:existing_vertical) { create(:vertical, name: category_name) }

    it 'returns hash with errors' do
      expect(create_category.errors).to eq(["name #{category_name} is already taken"])
    end
  end
end
