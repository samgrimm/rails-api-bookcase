class Book < ApplicationRecord
  validates :title, presence: true
  validates :isbn, uniqueness: true, length: { minimum: 9 }

  has_many :publications
  has_many :authors, through: :publications

  belongs_to :publisher

end
