require 'time'
require 'acceptance_spec_helper'

RSpec.describe 'Add six' do
  When { post(addsix_path, number: 33) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(parsed_response['result']).to eq 39 }
  And  { expect(Time.iso8601(parsed_response['at'])).to be_an_instance_of(Time) }
end
