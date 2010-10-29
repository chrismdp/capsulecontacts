require 'spec_helper'

describe "Capsule Contacts" do
  context "searching for contacts" do
      let(:person) { {"id"=>"5316141", "contacts"=>{"email"=>{"id"=>"9313439", "type"=>"Work", "emailAddress"=>"bob@example.com"}}, "pictureURL"=>"https://url.to/picture","firstName"=>"Bob", "lastName"=>"Builder"} }
      let(:organisation) { {"id"=>"5384785", "contacts"=>{"phone"=>{"id"=>"9413881", "phoneNumber"=>"+44 (0)877 777 77777"}}, "about"=>"SOURCE: http://blah", "pictureURL"=>"https://url.to/picture", "name"=>"Company"} }
      let(:sample_contacts) { {"parties"=>{"@size"=>"2", "organisation"=>organisation, "person"=>[person, person]}} }

    it "splits people and organisations up correctly" do
      Person.should_receive(:new).twice
      Organisation.should_receive(:new).once
      CapsuleContacts.from_search(sample_contacts)
    end

    it "returns people and organisations together in one array" do
      results = CapsuleContacts.from_search(sample_contacts)
      results.should be_a(Array)
      results.size.should == 3
    end

    it "handles no results correctly" do
      CapsuleContacts.from_search({"parties"=>{"@size"=>"0"}}).should == []
    end
  end
end

describe "Person" do
  context "creation from json" do
    let(:person_json) { {"id"=>"5316141", "contacts"=>{"email"=>[{"id"=>"9313439", "type"=>"Work", "emailAddress"=>"bob1@example.com"},{"id"=>"9313439", "type"=>"Work", "emailAddress"=>"bob2@example.com"}]}, "pictureURL"=>"https://url.to/picture","firstName"=>"Bob", "lastName"=>"Builder"} }

    subject { Person.new(person_json) }

    its(:id) { should == "5316141" }
    its(:name) { should == "Bob Builder" }
    its(:picture_url) { should == "https://url.to/picture" }

    it "contact methods should be an array of ContactMethods" do
      subject.should have(2).contact_methods
      subject.contact_methods.first.should be_a(ContactMethod)
      subject.contact_methods.first.value.should match(/bob1/)
      subject.contact_methods.last.value.should match(/bob2/)
    end
  end
end

describe "Organisation" do
  context "creation from json" do
    let(:organisation_json) { {"id"=>"5384785", "contacts"=>{"phone"=>{"id"=>"9413881", "phoneNumber"=>"+44 (0)877 777 77777"}}, "about"=>"SOURCE: http://blah", "pictureURL"=>"https://url.to/picture", "name"=>"Company"} }

    subject { Organisation.new(organisation_json) }

    its(:id) { should == '5384785' }
    its(:name) { should == 'Company' }
    its(:picture_url) { should == 'https://url.to/picture' }

    it "contact methods should be an array of ContactMethods" do
      subject.should have(1).contact_methods
      subject.contact_methods.first.should be_a(ContactMethod)
    end
  end
end

describe "Contact Method" do

  context "email extraction" do
    let(:data) { {"id"=>"9313439", "type"=>"Work", "emailAddress"=>"bob@example.com"} }
    subject { ContactMethod.new(data, 'email') }

    its(:type) { should == 'email' }
    its(:location) { should == 'Work' }
    its(:value) { should == 'bob@example.com' }
  end

  context "phone extraction" do
    let(:data) { {"id"=>"9313439", "type"=>"Mobile", "phoneNumber"=>"+44 7777 777 777"} }
    subject { ContactMethod.new(data, 'phone') }

    its(:type) { should == 'phone' }
    its(:location) { should == 'Mobile' }
    its(:value) { should == '+44 7777 777 777' }
  end
end
