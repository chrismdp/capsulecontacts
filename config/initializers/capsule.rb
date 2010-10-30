keys = {
  test: 'x',
  cucumber: 'x',
  development: ENV['CAPSULEAPI_KEY'],
  production: ENV['CAPSULEAPI_KEY']
}

PartyResource::Connector.add(:capsule,
  base_uri: 'https://edendevelopment.capsulecrm.com/api',
  username: keys[Rails.env.to_sym], password: 'x',
  headers: {
    'Accept' => 'application/json',
    'Content-type' => 'application/json',
    'User-agent' => 'edendevelopment-capsulecontacts/v0.1' });

#PartyResource.logger = lambda {|msg| puts "PR: "+msg }
