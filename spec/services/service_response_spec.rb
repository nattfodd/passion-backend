# frozen_string_literal: true

RSpec.describe ServiceResponse do
  subject(:service_response) { described_class.new(response) }

  context 'when response has errors' do
    let(:response_errors) { %w[foo bar] }
    let(:response) { { errors: response_errors } }

    it 'returns failure' do
      expect(service_response.failure?).to eq(true)
    end

    it 'does not return success' do
      expect(service_response.success?).to eq(false)
    end

    describe '#errors' do
      it 'returns response errors' do
        expect(service_response.errors).to eq(response_errors)
      end
    end
  end

  context 'when response has no errors' do
    let(:response) { double('Response') }

    it 'returns success' do
      expect(service_response.success?).to eq(true)
    end

    it 'does not return failure' do
      expect(service_response.failure?).to eq(false)
    end

    it 'returns response itself' do
      expect(service_response.response).to eq(response)
    end
  end
end
