class Category < ApplicationRecord
  has_many :category_relations
  has_many :books, through: :category_relation
end
