#
# Author:: James Turnbull <james@lovedthanlost.net>
# Module Name:: truesight
# Class:: truesight::dependencies
#
# Copyright 2011, Puppet Labs
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class truesight::dependencies {

  $repo_mod = $truesight::release ? {
    production  => '',
    staging     => '-staging',
    default     => '',
  }

  case $::operatingsystem {
    'RedHat', 'redhat', 'CentOS', 'centos', 'Amazon', 'Fedora': {

      yumrepo { 'truesight':
        descr    => "Truesight $::operatingsystemrelease $::architecture Repository ",
        enabled  => 1,
        baseurl  => $::operatingsystem ? {
          /(RedHat|redhat|CentOS|centos)/ =>  "http://yum$repo_mod.truesight.bmc.com/centos/os/$::operatingsystemrelease/$::architecture/",
          'Fedora'                        =>  "http://yum$repo_mod.truesight.bmc.com/centos/os/6.4/$::architecture/",
          'Amazon'                        =>  "http://yum$repo_mod.truesight.bmc.com/centos/os/6.4/$::architecture/",
        },
        gpgcheck => 1,
        gpgkey   => "http://yum$repo_mod.truesight.bmc.com/RPM-GPG-KEY-Truesight",
      }
    }

    'debian', 'ubuntu': {

      include apt

      $repo = $::operatingsystem ? {
        debian    => 'main',
        ubuntu    => 'universe',
        default   => undef,
      }

      apt::source { 'truesight':
        location   => inline_template('<%= "http://apt#{@repo_mod}.truesight.bmc.com/#{@operatingsystem.downcase}" %>'),
        repos      => $repo,
        key        => '6532CC20',
        key_source => "http://apt$repo_mod.truesight.bmc.com/APT-GPG-KEY-Truesight"
      }
    }

    default: {
      fail('Platform not supported by Truesight module. Patches welcomed.')
    }
  }
}
