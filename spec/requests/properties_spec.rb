require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  before(:all) do
    @property1 = FactoryBot.create(:property)
    @property2 = FactoryBot.create(:property)
    @property1.save
    @property2.save
  end

  # Test suite for GET /properties
  describe 'GET /properties' do
    before { get '/properties' }

    it 'should return properties' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /properties/:id
  describe 'GET /properties/:id' do
    before { get "/properties/#{@property1.id}" }

    context 'when the record exists' do
      it 'returns the property' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(@property1.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get '/properties/100' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end
  end

  # Test suite for POST /articles
  describe 'POST /articles' do
    # valid payload
    let(:valid_attributes) {{
                            name: 'Property 1',
                            property_type: 'house',
                            street: 'test street',
                            external_number: '1234',
                            neighborhood: 'test neighborhood',
                            city: 'test city',
                            country: 'AR',
                            rooms: 5,
                            bathrooms: 2 }
                          }

    context 'when the request is valid' do
      before { post '/properties', params: valid_attributes }

      it 'creates a property' do
        expect(json['name']).to eq('Property 1')
        expect(json['city']).to eq('test city')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/properties', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match('{"message":"Validation failed:')
      end
    end
  end

  # Test suite for PUT /properties/:id
  describe 'PUT /properties/:id' do
    let(:valid_attributes) { { name: 'New Name' } }

    context 'when the record exists' do
      before { put "/properties/#{@property1.id}", params: valid_attributes }

      it 'updates the record' do
        expect(json['name']).to eq('New Name')
      end

      it 'returns status code 202' do
        expect(response).to have_http_status(202)
      end
    end
  end

  # Test suite for DELETE /properties/:id
  describe 'DELETE /properties/:id' do
    before { delete "/properties/#{@property1.id}" }

    it 'returns the property' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(@property1.id)
    end

    it 'returns status code 202' do
      expect(response).to have_http_status(202)
    end
  end
end
