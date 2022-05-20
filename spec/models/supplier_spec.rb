require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'falso quanto _corporate_name_ for vazio' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: '', brand_name: 'Indústrias Wonka', nif: '0987565343120',
          full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
          email: 'contato@wonka.com', contact_number: '+557133224455'
        )

        # Act and Assert
        expect(supplier).not_to be_valid
      end

      it 'falso quanto _brand_name_ for vazio' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: '', nif: '0987565343120',
          full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
          email: 'contato@wonka.com', contact_number: '+557133224455'
        )

        # Act and Assert
        expect(supplier).not_to be_valid
      end

      it 'falso quanto _nif_ for vazio' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: 'Indústrias Wonka', nif: '',
          full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
          email: 'contato@wonka.com', contact_number: '+557133224455'
        )

        # Act and Assert
        expect(supplier).not_to be_valid
      end

      it 'falso quanto _email_ for vazio' do
        # Arrange
        supplier = Supplier.new(
          corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: 'Indústrias Wonka', nif: '0987565343120',
          full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
          email: '', contact_number: '+557133224455'
        )

        # Act and Assert
        expect(supplier).not_to be_valid
      end
    end

    it 'falso quanto _nif_ já está cadastrado' do
      # Arrange
      supplier1 = Supplier.create(
        corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: 'Indústrias Wonka', nif: '0987565343120',
        full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
        email: 'contato@wonka.com', contact_number: '+557133224455'
      )

      supplier2 = Supplier.new(
        corporate_name: 'Fazenda Boa Esperança', brand_name: 'Florafabe', nif: '0987565343120',
        full_address: 'BR 324, km330', city: 'Ibirapintaga', state: 'BA',
        email: 'contato@florafabe.com', contact_number: '+557335313804'
      )

      # Act and Assert
      expect(supplier2).not_to be_valid
    end

    it 'falso quando _nif_ tiver mais ou menos do que 14 caracteres' do
      # Arrange
      supplier = Supplier.new(
        corporate_name: 'Fazenda Boa Esperança', brand_name: 'Florafabe', nif: '098756534310',
        full_address: 'BR 324, km330', city: 'Ibirapintaga', state: 'BA',
        email: 'contato@florafabe.com', contact_number: '+557335313804'
      )

      # Act and Assert
      expect(supplier).not_to be_valid
    end

    it 'falso quando _nif_ receber caractere não numérico' do
      # Arrange
      supplier = Supplier.new(
        corporate_name: 'Fazenda Boa Esperança', brand_name: 'Florafabe', nif: '098756534312a',
        full_address: 'BR 324, km330', city: 'Ibirapintaga', state: 'BA',
        email: 'contato@florafabe.com', contact_number: '+557335313804'
      )

      # Act and Assert
      expect(supplier).not_to be_valid
    end

    it 'falso quando _email_ estiver com formato inválido' do
      # Arrange
      supplier = Supplier.new(
        corporate_name: 'Fazenda Boa Esperança', brand_name: 'Florafabe', nif: '0987565343120',
        full_address: 'BR 324, km330', city: 'Ibirapintaga', state: 'BA',
        email: 'contato@florafabe', contact_number: '+557335313804'
      )

      # Act and Assert
      expect(supplier).not_to be_valid
    end

    it 'falso quando _state_ tiver mais ou menos do que 2 caracteres' do
      # Arrange
      supplier = Supplier.new(
        corporate_name: 'Fazenda Boa Esperança', brand_name: 'Florafabe', nif: '0987565343120',
        full_address: 'BR 324, km330', city: 'Ibirapintaga', state: 'BAh',
        email: 'contato@florafabe.com', contact_number: '+557335313804'
      )

      # Act and Assert
      expect(supplier).not_to be_valid
    end
  end
end
