require 'rails_helper'

RSpec.describe "Publishers", :type => :request do
  describe "GET /publishers" do

    it "returns all the publishers" do
      publisher1 =  FactoryGirl.create(:publisher, name: "John Doe")
      publisher2 =  FactoryGirl.create(:publisher, name: "JK Rowling")
      get '/publishers'

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)

      publisher_names = body['data'].map{|publisher| publisher['attributes']['name'] }
      expect(publisher_names).to match_array(['John Doe', 'JK Rowling'])
    end
  end

  describe "GET /publishers/:id" do
    it "returns the specified publisher" do
      FactoryGirl.create :publisher, name: 'John Doe', id: 1

      get '/publishers/1'

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      publisher_name = body['data']['attributes']['name']
      expect(publisher_name) == 'John Doe'
    end
  end

  describe "POST /publishers" do
    it "creates the specified publisher" do
      publisher = {
      data: {
        type: "publishers",
        attributes: {
          name: "John Doe"
        }
      }
    }
    post '/publishers',
    params: publisher.to_json,
    headers: { 'Content-Type': 'application/vnd.api+json' }

    expect(response.status).to eq 201

    body = JSON.parse(response.body)

    publisher_name = body['data']['attributes']['name']
    expect(publisher_name) == 'John Doe'
    end
  end

  describe "PUT /publishers/:id" do
  it "updates the specified publisher" do
    FactoryGirl.create :publisher, name: 'John Doe', id: 1

    publisher = {
      data: {
        type: "publishers",
        id: 1,
        attributes: {
          name: "Damien White"
        }
      }
    }

    put '/publishers/1',
      params: publisher.to_json,
      headers: { 'Content-Type': 'application/vnd.api+json' }

    expect(response.status).to eq 200

    body = JSON.parse(response.body)

    publisher_name = body['data']['attributes']['name']
    expect(publisher_name) == 'Damien White'
  end
end
describe "DELETE /publishers/:id" do
  it "deletes the specified publisher" do
    FactoryGirl.create :publisher, name: 'John Doe', id: 1

    delete '/publishers/1'

    expect(response.status).to eq 204
  end
end

end
