require 'rails_helper'

RSpec.describe "Links", type: :request do
  base_url = '/api/v1'

  describe "GET /index" do
    it "returns http success" do
      get "#{base_url}/links/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      expect(Link.count).to be(0)
      post "#{base_url}/links/create", :params => { :link => {:display_text => "Anything", :url => "http://www.anything.com"} }
      expect(response).to have_http_status(:success)
      expect(Link.count).to be(1)
    end

    it "returns error for bad params" do
      post "#{base_url}/links/create", :params => { :link => {:display_text => nil, :url => "http://www.anything.com"} }
      expect(response).to have_http_status(400)
    end

    it "returns error for bad url" do
      post "#{base_url}/links/create", :params => { :link => {:display_text => 'Anything', :url => "www.anything"} }

      expect(response).to have_http_status(400)
      expect(json["message"]).to eq('Something went wrong with creating this link Anything')
      expect(json["details"]).to eq({"url"=>["is not a valid HTTP URL"]})
    end
  end

  context 'delete' do
    describe "DELETE /delete" do
      let(:link) { create :link }

      it "returns http success" do
        delete "#{base_url}/links/delete/#{link.id}"
        expect(response).to have_http_status(:success)
      end

      it "D-activates the link (deleting the link)" do
        expect(link.active).to eq(true)
        delete "#{base_url}/links/delete/#{link.id}"
        delete_link = Link.find_by_id(link.id)
        expect(delete_link.active).to eq(false)
      end

    end
  end
end
