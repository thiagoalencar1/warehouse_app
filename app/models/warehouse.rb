class Warehouse < ApplicationRecord
  has_many :orders
  has_many :stock_products

  validates :name, :code, :city, :description, :address, :postal_code, :area, presence: true
  validates :code, uniqueness: true
  validates :postal_code, format: { with: /\A\d{5}-\d{3}\z/, message: 'com formato inválido.' }
  validates :code, length: { is: 3, message: 'precisa ter 3 caracteres.' }

  def full_description
    "#{code} - #{name}"
  end
end
