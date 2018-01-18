require 'spec_helper'
describe 'plexpy' do

  context 'with defaults for all parameters' do
    it { should contain_class('plexpy') }
  end
end
