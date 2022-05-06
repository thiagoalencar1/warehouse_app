class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
  validates :cep, format: { with: /\A\d{5}-?\d{3}\z/, message: 'com formato inválido' }
end

# Pessoal, encontrei esse regex aqui: /^\d{5}-?\d{3}$/ .
# Parece que funcionou legal aqui.
