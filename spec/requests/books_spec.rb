require 'rails_helper'

RSpec.describe "Books", :type => :request do
  describe "GET /authors" do

    it "returns all the books" do
      publisher = FactoryGirl.create :publisher, name: 'Pragmatic Bookshelf'
      FactoryGirl.create :book, title: 'Rails 4 in Action', isbn: '9781937785587'
      FactoryGirl.create :book, title: 'Agile Web Development with Rails 4', isbn: '9781937785567', publisher: publisher
      get '/books'

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)

      book_titles = body['data'].map{|book| book['attributes']['title'] }
      expect(book_titles).to match_array(['Rails 4 in Action', 'Agile Web Development with Rails 4'])
    end
  end

  describe "GET /books/:id" do
    it "returns the specified book" do
      FactoryGirl.create :book, title: "Grit", isbn:"123445678", cover:"bulls.jpg"

      get '/books/1'

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      book_title = body['data']['attributes']['title']
      expect(book_title) == 'Grit'
    end
  end

  describe "POST /books" do
    it "creates the specified book" do
      publisher = FactoryGirl.create :publisher, name: 'Manning'
      json = {
        data: {
          type: "books",
          attributes: {
            title: "Rails 4 in Action",
            isbn: "9781937785587",
            publisher_id: 1
          }
        }
      }
    post '/books',
    params: json.to_json,
    headers: { 'Content-Type': 'application/vnd.api+json' }

    expect(response.status).to eq 201

    body = JSON.parse(response.body)

    book_title = body['data']['attributes']['title']
    expect(book_title) == 'Rails 4 in Action'
    end
  end

  describe "PUT /books/:id" do
  it "updates the specified book" do
    FactoryGirl.create :book, title: "Grit", isbn:"123445678", cover:"bulls.jpg", id: 1

    book = {
      data: {
        type: "books",
        id: 1,
        attributes: {
          title: "Gritts"
        }
      }
    }

    put '/books/1',
      params: book.to_json,
      headers: { 'Content-Type': 'application/vnd.api+json' }

    expect(response.status).to eq 200

    body = JSON.parse(response.body)

    book_title = body['data']['attributes']['title']
    expect(book_title) == 'Gritts'
  end
end
describe "DELETE /books/:id" do
  it "deletes the specified book" do
    FactoryGirl.create :book, title: "Grit", isbn:"123445678", cover:"bulls.jpg", id: 1

    delete '/books/1'

    expect(response.status).to eq 204
  end
end

end
