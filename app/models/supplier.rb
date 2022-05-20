class Supplier < ApplicationRecord
  has_many :product_models

  validates :corporate_name, :brand_name, :email, :nif, presence: true
  validates :nif, uniqueness: true
  validates :nif, length: { is: 14, message: 'deve ter 14 digitos.' }
  validates :nif, numericality: true
  validates :email, format: { with: /\w+@\w+\.{1}[a-zA-Z]{2,}/, message: 'com formato inválido.' }
  validates :state, length: { is: 2, message: 'deve ter 2 dígitos.' }
end
