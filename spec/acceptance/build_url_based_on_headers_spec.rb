require 'acceptance_spec_helper'

RSpec.describe 'Build URL based on request headers' do
  let(:account_id)          { 'acc000000000000000000001' }
  let(:base_url)            { '//custom.talkdesk.com' }
  let(:scheme)              { 'https' }

  context 'when sending X-Api-Base only' do
    Given { header 'X-Api-Base', base_url }
    When  { get root_path, account_id: account_id }
    Then  { expect(last_response.status).to be 200 }
    And   { expect(last_response.headers).to include('Content-Type' => 'application/hal+json') }
    And   { expect(last_response.body).to be_hal }
    And   { expect(last_response.body).to have_relation(:self) }
    And   { expect(parsed_response['_links']['self']['href']).to start_with('http://custom.talkdesk.com') }
  end

  context 'when sending X-Api-Scheme only' do
    Given { header 'X-Api-Scheme', scheme }
    When  { get root_path, account_id: account_id }
    Then  { expect(last_response.status).to be 200 }
    And   { expect(last_response.headers).to include('Content-Type' => 'application/hal+json') }
    And   { expect(last_response.body).to be_hal }
    And   { expect(last_response.body).to have_relation(:self) }
    And   { expect(parsed_response['_links']['self']['href']).to start_with('https://example.org') }
  end

  context 'when sending X-Api-Scheme and X-Api-Base' do
    Given { header 'X-Api-Scheme', scheme }
    Given { header 'X-Api-Base', base_url }
    Then  { get root_path, account_id: account_id }
    And   { expect(last_response.status).to be 200 }
    And   { expect(last_response.headers).to include('Content-Type' => 'application/hal+json') }
    And   { expect(last_response.body).to be_hal }
    And   { expect(last_response.body).to have_relation(:self) }
    And   { expect(parsed_response['_links']['self']['href']).to start_with('https://custom.talkdesk.com') }
  end
end
