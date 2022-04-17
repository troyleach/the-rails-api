class Link < ApplicationRecord
  validates_presence_of :display_text
  validates_presence_of :url
  validates :url, http_url: true
end

