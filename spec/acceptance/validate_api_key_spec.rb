require 'acceptance_spec_helper'

RSpec.describe 'api key validation' do
  context 'when no api key is configured' do
    Then { expect { get root_path }.to raise_error }

    context 'when in development mode' do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return('development')
      end

      When { get root_path }
      Then { expect(last_response.status).to be 200 }
    end
  end

  context 'when an api key is configured' do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('API_KEYS').and_return('abc,xyz')
    end

    context 'when the submitted key is valid' do
      let(:submitted_key) { 'xyz' }

      context 'when the key is provided as a query param' do
        When { get root_path, api_key: submitted_key }
        Then { expect(last_response.status).to be 200 }
      end

      context 'when the key is provided as a header' do
        Given { header 'X-Api-Key', submitted_key }
        When  { get root_path }
        Then  { expect(last_response.status).to be 200 }
      end
    end

    context 'when the submitted key is invalid' do
      context 'when no key is submitted' do
        When { get root_path }
        Then { expect(last_response.status).to be 401 }
      end

      context 'when the submitted key does not match the api key' do
        Given { header 'X-Api-Key', 'xyz-' }
        When  { get root_path }
        Then  { expect(last_response.status).to be 401 }
      end
    end
  end
end
