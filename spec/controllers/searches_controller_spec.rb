require 'spec_helper'

describe SearchesController do
  describe "GET 'new'" do
    it "should be successful" do
      get :new
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
      post :create, :q => "query"
    end

    it "asks the capsule API for the contacts first" do
      post :create, :q => "query"
      assigns[:results].should == results
    end
  end
end
