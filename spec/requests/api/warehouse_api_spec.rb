require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      # Arrange
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
        address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
      )
      # Act
      get "/api/v1/warehouses/#{warehouse.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'fail if warehouse not found' do
      # Arrange
      # Assert
      get '/api/v1/warehouses/99999999'
      # Act
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'success and ordered by name' do
      # Arrange
      Warehouse.create!(
        name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
        address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
      )

      Warehouse.create!(
        name: 'Aeroporto SSA', code: 'SSA', city: 'Salvador', area: 100_000, postal_code: '40000-000',
        address: 'Alameda dos Bambus, 200', description: 'Galpão destinado a cargas internacionais'
      )

      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first["name"]).to eq('Aeroporto SP')
      expect(json_response[1]["name"]).to eq('Aeroporto SSA')
    end

    it 'return empty if there is no warehouse' do
      # Arrange
      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq [] 
    end
  end
end