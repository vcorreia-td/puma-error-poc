require 'acceptance_spec_helper'

RSpec.describe 'GET /' do
  include_context 'Api Authentication'

  When { get root_path }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/hal+json') }
  And  { expect(last_response.body).to be_hal }
  And  { expect(last_response.body).to have_relation(:self) }
  And  { expect(last_response.body).to have_relation(:addsix) }
end
