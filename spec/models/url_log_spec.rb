require 'rails_helper'

RSpec.describe UrlLog, type: :model do

  it 'saves on successful refrence' do
    url = Url.create(orginalURL: "https://google.com")
    url_log = UrlLog.create(url_id: url.id, redirection_time: DateTime.now)
    expect(url_log.persisted?).to be_truthy
  end

  it 'doesnt save on bad refrence' do
    url_log = UrlLog.create(url_id: -1, redirection_time: DateTime.now)
    expect(url_log.persisted?).to be_falsey
  end
end