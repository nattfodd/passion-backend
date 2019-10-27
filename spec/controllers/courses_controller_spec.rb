# frozen_string_literal: true

RSpec.describe CoursesController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  describe '#index' do
    let!(:courses) { FactoryBot.create_list(:course, 3) }

    it 'returns status 200' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'returns list of courses' do
      get :index
      expect(json_response).to eq(courses.as_json)
    end
  end

  describe '#create' do
    subject(:create_course) { post :create, params: params }

    let(:category_id) { create(:category).id }
    let(:params) { { name: 'Foo Bar', category_id: category_id } }

    it 'returns status 200' do
      create_course
      expect(response.status).to eq(200)
    end

    it 'creates a new course' do
      expect { create_course }.to change(Course, :count).by(1)
    end

    it 'returns new course' do
      create_course
      expect(json_response['name']).to eq(params[:name])
    end

    describe 'when validation fails' do
      let(:category_id) { -1 }

      it 'returns 422' do
        create_course
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    subject(:update_course) { put :update, params: params }

    let(:course) { create(:course) }
    let(:new_name) { 'Foo Bar' }
    let(:params) { { id: course.id, name: new_name } }

    it 'returns status 200' do
      update_course
      expect(response.status).to eq(200)
    end

    it 'updates course' do
      expect { update_course }.to change { course.reload.name }.to(new_name)
    end
  end

  describe '#destroy' do
    subject(:destroy_course) { delete :destroy, params: params }

    let(:course) { create(:course) }
    let(:course_id) { course.id }
    let(:params) { { id: course.id } }

    it 'returns 200' do
      destroy_course
      expect(response.status).to eq(200)
    end

    it 'destroys course' do
      expect { destroy_course }.to change { Course.find_by(id: course_id).present? }.to(false)
    end
  end
end
