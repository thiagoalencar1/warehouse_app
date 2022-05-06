class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
  validates :cep, format: { with: /\d{5}-\d{3}\Z/, message: 'com formato inválido' }
end
