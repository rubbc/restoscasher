class Restaurant < ApplicationRecord
  searchkick
  belongs_to :user
  has_many :items
  acts_as_taggable_on :tags
end
