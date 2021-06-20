require 'rails_helper'

RSpec.describe Url, type: :model do

  it 'sets key on create' do
    url = Url.create(orginalURL: "https://google.com")
    expect(url.key).not_to be_nil
    expect(url.persisted?).to be_truthy
  end

  it 'has errors when invalid url is passed' do
    url = Url.create(orginalURL: "%%httpsgoogle.com")
    expect(url.persisted?).to be_falsey
    expect(url.errors.full_messages).to include("Redirect url Please pass in a valid url!")
  end

  it 'has errors when orginal url is missing' do
    url = Url.create
    expect(url.persisted?).to be_falsey
    expect(url.errors.full_messages).to include("Orginalurl can't be blank")
  end
end