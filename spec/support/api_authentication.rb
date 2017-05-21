RSpec.shared_context 'Api Authentication' do
  before do
    ENV['API_KEYS'] = 'test1,test2'
  end

  after do
    ENV['API_KEYS'] = nil
  end

  Given { header 'X-Api-key', 'test1'}
end
