require "rails_helper"

RSpec.describe "Web Requests", :type => :request do

  let(:redirect_url) { "https://google.com"}
  let(:shortern_params) { { "redirect_url": redirect_url}}

  describe "shortern url" do
    context "when required params are passed" do
      context "with proper url" do
        it "return 200" do
          post(shortern_path, params: shortern_params, as: :json)
          expect(response).to have_http_status(200)
        end
      end

      context "with malformed url" do
        let(:redirect_url) { "hello"}
        it "return 422" do
          post(shortern_path, params: shortern_params, as: :json)
          expect(response).to have_http_status(422)
          expect(response.body).to include("Please pass in a valid url")
        end
      end
    end

    context "when required params are not passed" do
      it "return 422" do
        post(shortern_path, params: nil, as: :json)
        expect(response).to have_http_status(422)
        expect(response.body).to include("Missing/Malformed params")
      end
    end
  end

  describe "redirect url" do
    context "with key preseent in the system" do
      before do
        Url.create(orginalURL: redirect_url)
      end
      it "return 322" do
        get redirect_path(Url.first.key)
        expect(response).to have_http_status(302)
      end

      it 'logs the redirection' do
        expect(Url.first.url_logs.count).to  eq(0)
        get redirect_path(Url.first.key)
        expect(Url.first.url_logs.count).to  eq(1)
      end
    end

    context "with key not preseent in the system" do
      let(:redirect_url) { "hello"}
      it "return 404" do
        get redirect_path("t3st")
        expect(response).to have_http_status(404)
      end
    end
  end
end