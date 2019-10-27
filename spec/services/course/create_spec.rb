# frozen_string_literal: true

RSpec.describe Course::Create do
  subject(:create_course) { described_class.new(params).call }

  let(:course_name) { 'FooBar' }
  let(:category) { create(:category) }
  let(:category_id) { category.id }
  let(:params) { { 'name' => course_name, 'category_id' => category_id }.with_indifferent_access }

  it 'creates new course' do
    expect { create_course }.to change(Category, :count).by(1)
  end

  it 'returns new course object' do
    expect(create_course).to be_a(ServiceResponse)
  end

  it 'returns new course object' do
    expect(create_course.response).to be_a(Course)
  end

  it 'returns a valid course object' do
    expect(create_course.response.attributes.slice('name', 'category_id')).to eq(params)
  end

  it 'sends notification' do
    expect(MessageBroker)
      .to receive_message_chain(:new, :call).with(instance_of(String)).with(no_args)
    create_course
  end

  context 'when built-in validation fails' do
    let(:category_id) { -1 }

    it 'returns hash with errors' do
      expect(create_course.errors).to eq(['Category must exist'])
    end
  end
end
