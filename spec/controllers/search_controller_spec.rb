require 'spec_helper'

describe SearchController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "Searching for contacts" do
    let(:results) { [mock(:contact)] }
    before do
      CapsuleContacts.stub(:search).and_return(results)
    end
    it "asks the capsule API for the contacts first" do
      CapsuleContacts.should_receive(:search).with("query")
      get 'search', :q => "query"
    end

    it "asks the capsule API for the contacts first" do
      get 'search', :q => "query"
      assigns[:results].should == results
    end
  end
end
