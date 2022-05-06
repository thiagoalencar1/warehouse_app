require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'falso quando _name_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: '', code: 'RIO', address: 'Endereço', city: 'Rio',
          cep: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and AssertP
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _code_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: '', address: 'Endereço', city: 'Rio',
          cep: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _address_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: '', city: 'Rio',
          cep: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _city_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: '',
          cep: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _cep_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
          cep: '', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _area_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
          cep: '25000-000', area: nil, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _description_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
          cep: '25000-000', area: 1000, description: ''
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end
    end

    it 'falso quando _code_ já está em uso' do
      # Arrange
      warehouse1 = Warehouse.create(
        name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
        cep: '25000-000', area: 1000, description: 'Alguma descrição'
      )

      warehouse2 = Warehouse.new(
        name: 'Salvador', code: 'RIO', address: 'Av. Getúlio Vargas', city: 'Salvador',
        cep: '40000-000', area: 1_000_000, description: 'Bora Baêa!'
      )

      # Act and Assert
      expect(warehouse2).not_to be_valid
    end

    it 'verdadeiro quando o formato do _cep_ é 00000-000' do
      # Arrange
      warehouse = Warehouse.new(
        name: 'Salvador', code: 'RIO', address: 'Av. Getúlio Vargas', city: 'Salvador',
        cep: '40000-000', area: 1_000_000, description: 'Bora Baêa!'
      )

      # Act and Assert
      expect(warehouse).to be_valid
    end

    it 'falso quando o formato do _cep_ não é 00000-000' do
      # Arrange
      warehouse = Warehouse.new(
        name: 'Salvador', code: 'RIO', address: 'Av. Getúlio Vargas', city: 'Salvador',
        cep: '00000-0000', area: 1_000_000, description: 'Bora Baêa!'
      )

      # Act and Assert
      expect(warehouse).not_to be_valid
    end
  end
end
