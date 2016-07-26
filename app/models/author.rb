class Author < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }

  has_many :publications
  has_many :books, through: :publications
end
