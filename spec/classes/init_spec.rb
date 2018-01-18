# Main test class

require 'spec_helper'

describe 'plexpy' do
  context 'with defaults for all parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('plexpy') }

    describe 'plexpy' do
      it { is_expected.to contain_user('plexpy') }

      it { is_expected.to contain_vcsrepo('/opt/plexpy').with_owner('plexpy') }
      it { is_expected.to contain_vcsrepo('/opt/plexpy').with_group('plexpy') }
      it { is_expected.to contain_vcsrepo('/opt/plexpy').with_source('https://github.com/JonnyWong16/plexpy.git') }
      it { is_expected.to contain_vcsrepo('/opt/plexpy').with_revision('master') }

      it { is_expected.to contain_file('/opt/plexpy').with_owner('plexpy') }
      it { is_expected.to contain_file('/opt/plexpy').with_group('plexpy') }

      it { is_expected.to contain_file('/etc/plexpy').with_owner('plexpy') }
      it { is_expected.to contain_file('/etc/plexpy').with_group('plexpy') }

      it { is_expected.to contain_file('/usr/lib/systemd/system/plexpy.service').with_owner('root') }
      it { is_expected.to contain_file('/usr/lib/systemd/system/plexpy.service').with_group('root') }
      it { is_expected.to contain_file('/usr/lib/systemd/system/plexpy.service').with_mode('0644') }

      it { is_expected.to contain_service('plexpy').with_ensure('running') }
      it { is_expected.to contain_service('plexpy').with_ensure('true') }
    end
  end
end
