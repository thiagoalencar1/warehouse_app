class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
  validates :cep, format: { with: /[0-9]{5}-[0-9]{3}/, message: 'Formato de cep inválido' }
end
