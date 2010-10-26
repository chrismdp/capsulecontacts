require 'spec_helper'

describe "Capsule Contacts" do
  context "searching for contacts" do
      let(:person) { {"id"=>"5316141", "contacts"=>{"email"=>{"id"=>"9313439", "type"=>"Work", "emailAddress"=>"bob@example.com"}}, "pictureURL"=>"https://url.to/picture","firstName"=>"Bob", "lastName"=>"Builder"} }
      let(:organisation) { {"id"=>"5384785", "contacts"=>{"phone"=>{"id"=>"9413881", "phoneNumber"=>"+44 (0)877 777 77777"}}, "about"=>"SOURCE: http://blah", "pictureURL"=>"https://url.to/picture", "name"=>"Company"} }
      let(:sample_contacts) { {"parties"=>{"@size"=>"2", "organisation"=>organisation, "person"=>[person, person]}} }

    it "splits people and organisations up correctly" do
      Person.should_receive(:from_json).twice
      Organisation.should_receive(:from_json).once
      CapsuleContacts.from_search(sample_contacts)
    end
  end
end
