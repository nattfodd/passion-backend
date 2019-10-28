# frozen_string_literal: true

RSpec.describe Vertical::Create do
  subject(:create_vertical) { described_class.new(params).call }

  let(:vertical_name) { build(:vertical).name }
  let(:params) { { 'name' => vertical_name }.with_indifferent_access }

  it 'creates new vertical' do
    expect { create_vertical }.to change(Vertical, :count).by(1)
  end

  it 'returns a ServiceResponse object' do
    expect(create_vertical).to be_a(ServiceResponse)
  end

  it 'returns new vertical object' do
    expect(create_vertical.response).to be_a(Vertical)
  end

  it 'returns a valid vertical object' do
    expect(create_vertical.response.attributes.slice('name')).to eq(params)
  end

  it 'sends notification' do
    expect(MessageBroker)
      .to receive_message_chain(:new, :call).with(instance_of(String)).with(no_args)
    create_vertical
  end

  context 'when the name is already taken by vertical' do
    let!(:existing_vertical) { create(:vertical, name: vertical_name) }

    it 'returns hash with errors' do
      expect(create_vertical.errors).to eq(["name #{vertical_name} is already taken"])
    end
  end

  context 'when the name is already taken by category' do
    let!(:existing_category) { create(:category, name: vertical_name) }

    it 'returns hash with errors' do
      expect(create_vertical.errors).to eq(["name #{vertical_name} is already taken"])
    end
  end
end
