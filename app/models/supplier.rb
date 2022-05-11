class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :email, :nif, presence: true
  validates :nif, uniqueness: true
  validates :nif, length: { is: 13, message: 'precisa ter 13 digitos.' }
  validates :nif, format: { with: /\A\d{13}\z/, message: 'só aceita números.' }
  validates :email, format: { with: /\w+@\w+\.{1}[a-zA-Z]{2,}/, message: 'com formato inválido.' }
end
