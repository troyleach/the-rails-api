require 'rails_helper'

RSpec.describe Link, type: :model do
  subject {
    described_class.new(
      display_text: 'Anything',
      url: 'https://www.anything.com')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.display_text = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without https" do
    subject.url = 'www.anything.com'
    expect(subject).to_not be_valid
  end

  it "active defaults to true" do
    expect(subject.active).to be true 
  end
end
