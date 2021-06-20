class Url < ApplicationRecord
  has_many :url_logs
  before_validation :set_key, on: :create

  validates_presence_of :orginalURL, :key
  validate :url_format

  def set_key
    key = ""
    loop do
      key = SecureRandom.base64(2)
      break unless Url.find_by(key: key)
    end
    self.key = key
  end

  private

  def url_format
    unless url_valid? self.orginalURL
      errors.add :redirect_url, "Please pass in a valid url!"
    end
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end