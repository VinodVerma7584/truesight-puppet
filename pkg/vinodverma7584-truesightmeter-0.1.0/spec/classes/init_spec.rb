require 'spec_helper'
describe 'truesightmeter' do

  context 'with defaults for all parameters' do
    it { should contain_class('truesightmeter') }
  end
end
