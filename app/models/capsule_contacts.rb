PartyResource::Connector.add(:capsule,
  base_uri: 'https://edendevelopment.capsulecrm.com/api',
  username: ENV['CAPSULEAPI_KEY'], password: 'x',
  headers: {
    'Accept' => 'application/json',
    'Content-type' => 'application/json',
    'User-agent' => 'edendevelopment-capsulecontacts/v0.1' });

class CapsuleContacts
  include PartyResource

  property :id
  property :firstName
  property :lastName

  connect :search, get: '/party?q=:query', with: :query, as: [self, :from_search]

  def self.from_search(data)
    people = create_contacts_for(Person, data["parties"]["person"])
    organisations = create_contacts_for(Organisation, data["parties"]["organisation"])
  end

private

  def self.create_contacts_for(klass, data)
    data = [data] unless data.is_a?(Array)
    data.map { |p| klass.from_json(p) }
  end
end

class Person
  def self.from_json

  end
end

class Organisation
  def self.from_json

  end
end

