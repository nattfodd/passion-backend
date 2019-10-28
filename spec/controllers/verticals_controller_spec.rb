# frozen_string_literal: true

RSpec.describe VerticalsController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  before do
    allow(controller).to receive(:doorkeeper_token) { double(acceptable?: true) }
  end

  describe '#index' do
    let!(:verticals) { FactoryBot.create_list(:vertical, 3) }

    it 'returns status 200' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'returns list of verticals' do
      get :index
      expect(json_response).to eq(verticals.as_json)
    end
  end

  describe '#create' do
    subject(:create_vertical) { post :create, params: params }

    let(:params) { { name: 'Foo Bar' } }

    it 'returns status 200' do
      create_vertical
      expect(response.status).to eq(200)
    end

    it 'creates a new vertical' do
      expect { create_vertical }.to change(Vertical, :count).by(1)
    end

    it 'returns new vertical' do
      create_vertical
      expect(json_response['name']).to eq(params[:name])
    end

    describe 'when validation fails' do
      let(:existing_name) { 'Foo Bar' }
      let!(:existing_vertical) { create(:vertical, name: existing_name) }
      let(:params) { { name: existing_name } }

      it 'returns 422' do
        create_vertical
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    subject(:update_vertical) { put :update, params: params }

    let(:vertical) { create(:vertical) }
    let(:new_name) { 'Foo Bar' }
    let(:params) { { id: vertical.id, name: new_name } }

    it 'returns status 200' do
      update_vertical
      expect(response.status).to eq(200)
    end

    it 'updates vertical' do
      expect { update_vertical }.to change { vertical.reload.name }.to(new_name)
    end
  end

  describe '#destroy' do
    subject(:destroy_vertical) { delete :destroy, params: params }

    let(:vertical) { create(:vertical) }
    let(:vertical_id) { vertical.id }
    let(:params) { { id: vertical_id } }

    it 'returns 200' do
      destroy_vertical
      expect(response.status).to eq(200)
    end

    it 'destroys vertical' do
      expect { destroy_vertical }.to change { Vertical.find_by(id: vertical_id).present? }.to(false)
    end
  end
end
