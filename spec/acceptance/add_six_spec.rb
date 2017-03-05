require 'acceptance_spec_helper'

RSpec.describe 'Add six' do
  When { post(addsix_path, number: 33) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/hal+json') }
  And  { expect(last_response.body).to be_hal }
  And  { expect(last_response.body).to have_relation(:self)}
  And  { expect(parsed_response['result']).to eq 39 }
  And  { expect(parsed_response['at']).to_not be nil }
end
