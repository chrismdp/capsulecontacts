PartyResource::Connector.add(:capsule,
  base_uri: 'https://edendevelopment.capsulecrm.com/api',
  username: ENV['CAPSULEAPI_KEY'], password: 'x',
  headers: {
    'Accept' => 'application/json',
    'Content-type' => 'application/json',
    'User-agent' => 'edendevelopment-capsulecontacts/v0.1' });

#PartyResource.logger = lambda {|msg| puts "PR: "+msg }
module FromJsonUtils

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def create_for(klass, data, *args)
      return [] if data.nil?
      data = [data] unless data.is_a?(Array)
      data.map { |p| klass.new(p, *args) }
    end
  end
end

module Contactable
  def self.included(klass)
    klass.extend ClassMethods
    klass.property :contact_methods, :from => :contacts, :as => [:self, :create_contact_methods]
  end

  module ClassMethods
    def create_contact_methods(data)
      [
        create_for(ContactMethod, data[:phone], 'phone'),
        create_for(ContactMethod, data[:email], 'email')
      ].flatten
    end
  end
end

class CapsuleContacts
  include PartyResource
  include FromJsonUtils

  connect :search, get: '/party?q=:query', with: :query, as: [self, :from_search]

  def self.from_search(data)
    #puts "*" * 50, data.inspect
    people = create_for(Person, data["parties"]["person"])
    organisations = create_for(Organisation, data["parties"]["organisation"])
    [people, organisations].flatten
  end
end

class ContactMethod
  include FromJsonUtils

  attr :type
  attr :location
  attr :value

  FIELDS = {'phone' => 'phoneNumber', 'email' => 'emailAddress' }

  def initialize(data, type)
    @type = type
    @location = data["type"]
    @value = data[FIELDS[@type]]
  end
end

class Person
  include PartyResource
  include FromJsonUtils

  include Contactable

  property :id
  property :first_name, :from => :firstName
  property :last_name, :from => :lastName
  property :picture_url, :from => :pictureURL

  def name
    "#{first_name} #{last_name}"
  end

  def initialize(params)
    populate_properties(params)
  end
end

class Organisation
  include PartyResource
  include FromJsonUtils

  include Contactable

  property :id
  property :name
  property :picture_url, :from => :pictureURL

  def initialize(params)
    populate_properties(params)
  end
end

