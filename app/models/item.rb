class Item < ApplicationRecord
  belongs_to :restaurant
  validates :name, :category, :price, presence: true
end
