require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'falso quando _name_ for vazio' do
        # Arrange
        supplier = Supplier.create!(
          brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
          full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
          email: 'vemnimim@lg.com', contact_number: '123456789'
        )

        product_model = ProductModel.new(
          name: '', weight: 5290, width: 70, height: 45, depth: 5,
          sku: 'LG29wk600', supplier:
        )

        # Act and Assert
        expect(product_model).not_to be_valid
      end
      it 'falso quando _weight_ for vazio' do
        # Arrange
        supplier = Supplier.create!(
          brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
          full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
          email: 'vemnimim@lg.com', contact_number: '123456789'
        )

        product_model = ProductModel.new(
          name: 'Monitor UltraWide 29\'', width: 70, height: 45, depth: 5,
          sku: 'LG29wk600', supplier:
        )

        # Act and Assert
        expect(product_model).not_to be_valid
      end
    end

    it 'falso quando _sku_ já está cadastrado' do
      # Arrange
      supplier = Supplier.create!(
        brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
        full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
        email: 'vemnimim@lg.com', contact_number: '123456789'
      )

      product_model1 = ProductModel.create(
        name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
        sku: 'LG29wk600-0980-FHFIU', supplier:
      )

      product_model2 = ProductModel.new(
        name: 'Televisão Megablaster', weight: 1000, width: 750, height: 1000, depth: 10,
        sku: 'LG29wk600-0980-FHFIU', supplier:
      )

      # Act and Assert
      expect(product_model2).not_to be_valid
    end

    it 'falso quando _sku_ tiver mais ou menos do que 20 caracteres.' do
      # Arrange
      supplier = Supplier.create!(
        brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
        full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
        email: 'vemnimim@lg.com', contact_number: '123456789'
      )

      product_model = ProductModel.create(
        name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
        sku: 'LG29wk600-0980', supplier:
      )

      # Act and Assert
      expect(product_model).not_to be_valid
    end

    it 'falso quando peso e medidas forem igual ou menor que zero.' do
      # Arrange
      supplier = Supplier.create!(
        brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
        full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
        email: 'vemnimim@lg.com', contact_number: '123456789'
      )

      product_model = ProductModel.create(
        name: 'Monitor UltraWide 29\'', weight: 0, width: -1, height: 0, depth: 0,
        sku: 'LG29wk600-0980-12304', supplier:
      )

      # Act and Assert
      expect(product_model).not_to be_valid
    end
  end
end
