class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :email, :nif, presence: true
  validates :nif, uniqueness: true
  validates :nif, length: { is: 13, message: 'deve ter 13 digitos.' }
  validates :nif, format: { with: /\A\d{13}\z/, message: 'só aceita números.' }
  validates :email, format: { with: /\w+@\w+\.{1}[a-zA-Z]{2,}/, message: 'com formato inválido.' }
  validates :state, length: { is: 2, message: 'deve ter 2 dígitos.' }
end
