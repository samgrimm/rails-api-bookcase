class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :isbn, :cover
end
