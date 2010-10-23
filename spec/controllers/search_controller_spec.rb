require 'spec_helper'

describe SearchController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "Searching for contacts" do
    it "asks the capsule API for the contacts first"
  end
end
