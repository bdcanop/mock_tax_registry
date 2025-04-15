require 'sinatra'
require 'json'

set :port, 4567
set :bind, '0.0.0.0'

MOCK_DB = {
  "12-3456789" => { active: true, name: "A very important company", address: "A very good address" },
  "98-7654321" => { active: false },
  "GB 123 4567 86" => { active: true, name: "Tea & Biscuits Ltd.", address: "10 Downing St, London" },
  "GB 111 1111 18" => { active: false },
  "DE 123456788" => { active: true, name: "Berlin Enterprises GmbH", address: "Unter den Linden 5, Berlin" },
  "DE 111111114" => { active: false }
}

get '/api/validate' do
  content_type :json
  number = params['number']

  if number.nil?
    status 400
    return { error: "Missing number parameter" }.to_json
  end

  record = MOCK_DB[number]

  if record.nil?
    status 404
    return { error: "Not Found" }.to_json
  end

  {
    active: record[:active],
    name: record[:name],
    address: record[:address]
  }.to_json
end
