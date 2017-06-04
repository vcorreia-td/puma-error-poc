require_relative '../../../web/helpers/authenticator'

RSpec.describe MyServiceName::Helpers::Authenticator do

  subject { described_class }

  describe '.call' do
    let(:call) { subject.call(auth_keys: api_keys, submitted_key: key) }

    context 'when there is more than one comma separated authentication key' do
      let(:api_keys) { 'abc,xyz' }

      context 'when the submitted key matches one of the authentication keys' do
        let(:key) { 'xyz' }

        it do
          expect(call).to eq true
        end
      end

      context 'when the submitted key does not match one of the authentication keys' do
        let(:key) { 'xy' }

        it do
          expect(call).to eq false
        end
      end
    end

    context 'when there is only one authentication key' do
      let(:api_keys) { 'abc' }

      context 'when the submitted key matches the authentication key' do
        let(:key) { 'abc' }

        it do
          expect(call).to eq true
        end
      end

      context 'when the submitted key matches the authentication key' do
        let(:key) { 'xy' }

        it do
          expect(call).to eq false
        end
      end
    end

    context 'when the athentic keys is empty' do
      let(:api_keys) { '' }
      let(:key) { '' }

      it do
        expect { call }.to raise_error described_class::InvalidAuthKeys
      end
    end

    context 'when the authentication keys is nil' do
      let(:api_keys) { nil }
      let(:key) { '' }

      it do
        expect { call }.to raise_error described_class::InvalidAuthKeys
      end
    end
  end
end
