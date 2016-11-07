# PlexPy Module

class plexpy (
  String $basedir   = '/opt/plexpy',
  String $configdir = '/etc/plexpy',
  String $user      = 'plexpy',
  String $repo_url  = 'https://github.com/JonnyWong16/plexpy.git',
  Boolean $latest   = true,
)  {

  user { $user :
    ensure     => present,
    managehome => true,
  }

  if $latest {
    vcsrepo { $basedir :
      ensure   => present,
      provider => git,
      source   => $repo_url,
      revision => 'master',
    }
  }
  else {
    vcsrepo { $basedir :
      ensure   => present,
      provider => git,
      source   => $repo_url,
      owner    => $user,
      group    => $user,
    }
  }

  file { $basedir :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    recurse => true,
    ignore  => ['.git'],
    require => Vcsrepo[$basedir],
  }

  file { $configdir :
    ensure => directory,
    owner  => $user,
    group  => $user,
  }

  file { 'plexpy_systemd' :
    ensure  => present,
    path    => '/usr/lib/systemd/system/plexpy.service',
    source  => 'puppet:///modules/plexpy/plexpy.service',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Vcsrepo[$basedir],
  }

  service { 'plexpy' :
    ensure    => running,
    enable    => true,
    require   => [ File[$basedir], User[$user] ],
    subscribe => [ Vcsrepo[$basedir], File['plexpy_systemd'], File[$configdir] ],
  }
}

