# frozen_string_literal: true

RSpec.describe CategoriesController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  before do
    allow(controller).to receive(:doorkeeper_token) { double(acceptable?: true) }
  end

  describe '#index' do
    let!(:categories) { FactoryBot.create_list(:category, 3) }

    it 'returns status 200' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'returns list of categories' do
      get :index
      expect(json_response).to eq(categories.as_json)
    end

    context 'when vertical_id param is present' do
      let(:desired_category) { categories.first }

      it 'returns only categories for the given vertical' do
        get :index, params: { vertical_id: desired_category.vertical_id }
        expect(json_response).to eq([desired_category.as_json])
      end
    end
  end

  describe '#create' do
    subject(:create_category) { post :create, params: params }

    let(:vertical_id) { create(:vertical).id }
    let(:params) { { name: 'Foo Bar', vertical_id: vertical_id } }

    it 'returns status 200' do
      create_category
      expect(response.status).to eq(200)
    end

    it 'creates a new category' do
      expect { create_category }.to change(Category, :count).by(1)
    end

    it 'returns new category' do
      create_category
      expect(json_response['name']).to eq(params[:name])
    end

    describe 'when validation fails' do
      let(:vertical_id) { -1 }

      it 'returns 422' do
        create_category
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    subject(:update_category) { put :update, params: params }

    let(:category) { create(:category) }
    let(:new_name) { 'Foo Bar' }
    let(:params) { { id: category.id, name: new_name } }

    it 'returns status 200' do
      update_category
      expect(response.status).to eq(200)
    end

    it 'updates category' do
      expect { update_category }.to change { category.reload.name }.to(new_name)
    end
  end

  describe '#destroy' do
    subject(:destroy_category) { delete :destroy, params: params }

    let(:category) { create(:category) }
    let(:category_id) { category.id }
    let(:params) { { id: category_id } }

    it 'returns 200' do
      destroy_category
      expect(response.status).to eq(200)
    end

    it 'destroys category' do
      expect { destroy_category }.to change { Category.find_by(id: category_id).present? }.to(false)
    end
  end
end
