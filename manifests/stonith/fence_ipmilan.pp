# == Define: pacemaker::stonith::fence_ipmilan
#
# Module for managing Stonith for fence_ipmilan.
#
# WARNING: Generated by "rake generate_stonith", manual changes will
# be lost.
#
# === Parameters
#
# [*auth*]
# IPMI Lan Auth type (md5, password, or none)
#
# [*ipaddr*]
# IPMI Lan IP to talk to
#
# [*passwd*]
# Password (if required) to control power on IPMI device
#
# [*passwd_script*]
# Script to retrieve password (if required)
#
# [*lanplus*]
# Use Lanplus to improve security of connection
#
# [*login*]
# Username/Login (if required) to control power on IPMI device
#
# [*timeout*]
# Timeout (sec) for IPMI operation
#
# [*cipher*]
# Ciphersuite to use (same as ipmitool -C parameter)
#
# [*method*]
# Method to fence (onoff or cycle)
#
# [*power_wait*]
# Wait X seconds after on/off operation
#
# [*delay*]
# Wait X seconds before fencing is started
#
# [*privlvl*]
# Privilege level on IPMI device
#
# [*verbose*]
# Verbose mode
#
#  [*interval*]
#   Interval between tries.
#
# [*ensure*]
#   The desired state of the resource.
#
# [*tries*]
#   The numbre of tries.
#
# [*try_sleep*]
#   Time to sleep between tries.
#
# [*pcmk_host_list*]
#   List of Pacemaker hosts.
#
# === Dependencies
#  None
#
# === Authors
#
# Generated by rake generate_stonith task.
#
# === Copyright
#
# Copyright (C) 2016 Red Hat Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
define pacemaker::stonith::fence_ipmilan (
  $auth           = undef,
  $ipaddr         = undef,
  $passwd         = undef,
  $passwd_script  = undef,
  $lanplus        = undef,
  $login          = undef,
  $timeout        = undef,
  $cipher         = undef,
  $method         = undef,
  $power_wait     = undef,
  $delay          = undef,
  $privlvl        = undef,
  $verbose        = undef,

  $interval       = '60s',
  $ensure         = present,
  $pcmk_host_list = undef,

  $tries          = undef,
  $try_sleep      = undef,

) {
  $auth_chunk = $auth ? {
    undef   => '',
    default => "auth=\"${auth}\"",
  }
  $ipaddr_chunk = $ipaddr ? {
    undef   => '',
    default => "ipaddr=\"${ipaddr}\"",
  }
  $passwd_chunk = $passwd ? {
    undef   => '',
    default => "passwd=\"${passwd}\"",
  }
  $passwd_script_chunk = $passwd_script ? {
    undef   => '',
    default => "passwd_script=\"${passwd_script}\"",
  }
  $lanplus_chunk = $lanplus ? {
    undef   => '',
    default => "lanplus=\"${lanplus}\"",
  }
  $login_chunk = $login ? {
    undef   => '',
    default => "login=\"${login}\"",
  }
  $timeout_chunk = $timeout ? {
    undef   => '',
    default => "timeout=\"${timeout}\"",
  }
  $cipher_chunk = $cipher ? {
    undef   => '',
    default => "cipher=\"${cipher}\"",
  }
  $method_chunk = $method ? {
    undef   => '',
    default => "method=\"${method}\"",
  }
  $power_wait_chunk = $power_wait ? {
    undef   => '',
    default => "power_wait=\"${power_wait}\"",
  }
  $delay_chunk = $delay ? {
    undef   => '',
    default => "delay=\"${delay}\"",
  }
  $privlvl_chunk = $privlvl ? {
    undef   => '',
    default => "privlvl=\"${privlvl}\"",
  }
  $verbose_chunk = $verbose ? {
    undef   => '',
    default => "verbose=\"${verbose}\"",
  }

  $pcmk_host_value_chunk = $pcmk_host_list ? {
    undef   => '$(/usr/sbin/crm_node -n)',
    default => $pcmk_host_list,
  }

  # $title can be a mac address, remove the colons for pcmk resource name
  $safe_title = regsubst($title, ':', '', 'G')

  if($ensure == absent) {
    exec { "Delete stonith-fence_ipmilan-${safe_title}":
      command => "/usr/sbin/pcs stonith delete stonith-fence_ipmilan-${safe_title}",
      onlyif  => "/usr/sbin/pcs stonith show stonith-fence_ipmilan-${safe_title} > /dev/null 2>&1",
      require => Class['pacemaker::corosync'],
    }
  } else {
    package {
      'fence-agents-ipmilan': ensure => installed,
    } ->
    exec { "Create stonith-fence_ipmilan-${safe_title}":
      command   => "/usr/sbin/pcs stonith create stonith-fence_ipmilan-${safe_title} fence_ipmilan pcmk_host_list=\"${pcmk_host_value_chunk}\" ${auth_chunk} ${ipaddr_chunk} ${passwd_chunk} ${passwd_script_chunk} ${lanplus_chunk} ${login_chunk} ${timeout_chunk} ${cipher_chunk} ${method_chunk} ${power_wait_chunk} ${delay_chunk} ${privlvl_chunk} ${verbose_chunk}  op monitor interval=${interval}",
      unless    => "/usr/sbin/pcs stonith show stonith-fence_ipmilan-${safe_title} > /dev/null 2>&1",
      tries     => $tries,
      try_sleep => $try_sleep,
      require   => Class['pacemaker::corosync'],
    } ~>
    exec { "Add non-local constraint for stonith-fence_ipmilan-${safe_title}":
      command     => "/usr/sbin/pcs constraint location stonith-fence_ipmilan-${safe_title} avoids ${pcmk_host_value_chunk}",
      tries       => $tries,
      try_sleep   => $try_sleep,
      refreshonly => true,
    }
  }
}
