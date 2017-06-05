RSpec.shared_context 'Api Authentication' do
  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('API_KEYS').and_return('test1,test2')
  end

  Given { header 'X-Api-Key', 'test1' }
end
