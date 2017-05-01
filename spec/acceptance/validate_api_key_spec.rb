require 'acceptance_spec_helper'

RSpec.describe 'api key validation' do
  context 'when no api key is configured' do
    When { get root_path }
    Then { expect(last_response.status).to be 200 }
  end

  context 'when an api key is configured' do
    let(:api_key) { 'xyz' }

    before do
      ENV['API_KEY'] = api_key
    end

    after do
      ENV['API_KEY'] = nil
    end

    context 'when the submitted key is valid' do
      context 'when the key is provided as a query param' do
        When { get root_path, api_key: api_key }
        Then { expect(last_response.status).to be 200 }
      end

      context 'when the key is provided as a header' do
        Given { header 'Api-Key', api_key }
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
        Given { header 'Api-Key', 'xyz-' }
        When  { get root_path }
        Then  { expect(last_response.status).to be 401 }
      end
    end
  end
end
