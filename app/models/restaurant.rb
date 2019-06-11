class Restaurant < ApplicationRecord
  has_many :items
  acts_as_taggable_on :tags
end
