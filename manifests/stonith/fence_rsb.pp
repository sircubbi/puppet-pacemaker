# == Define: pacemaker::stonith::fence_rsb
#
# Module for managing Stonith for fence_rsb.
#
# WARNING: Generated by "rake generate_stonith", manual changes will
# be lost.
#
# === Parameters
#
# [*ipaddr*]
#   IP Address or Hostname
#
# [*login*]
#   Login Name
#
# [*passwd*]
#   Login password or passphrase
#
# [*secure*]
#   SSH connection
#
# [*cmd_prompt*]
#   Force Python regex for command prompt
#
# [*ipport*]
#   TCP/UDP port to use for connection with device
#
# [*inet4_only*]
#   Forces agent to use IPv4 addresses only
#
# [*inet6_only*]
#   Forces agent to use IPv6 addresses only
#
# [*passwd_script*]
#   Script to retrieve password
#
# [*identity_file*]
#   Identity file for ssh
#
# [*ssh_options*]
#   SSH options to use
#
# [*action*]
#   Fencing Action
#
# [*verbose*]
#   Verbose mode
#
# [*debug*]
#   Write debug information to given file
#
# [*power_timeout*]
#   Test X seconds for status change after ON/OFF
#
# [*shell_timeout*]
#   Wait X seconds for cmd prompt after issuing command
#
# [*login_timeout*]
#   Wait X seconds for cmd prompt after login
#
# [*power_wait*]
#   Wait X seconds after issuing ON/OFF
#
# [*delay*]
#   Wait X seconds before fencing is started
#
# [*retry_on*]
#   Count of attempts to retry power on
#
#  [*interval*]
#   Interval between tries.
#
# [*ensure*]
#   The desired state of the resource.
#
# [*tries*]
#   The number of tries.
#
# [*try_sleep*]
#   Time to sleep between tries.
#
# [*pcmk_host_list*]
#   List of Pacemaker hosts.
#
# [*meta_attr*]
#   (optional) String of meta attributes
#   Defaults to undef
#
# [*deep_compare*]
#   Enable deep comparing of resources and bundles
#   When set to true a resource will be compared in full (options, meta parameters,..)
#   to the existing one and in case of difference it will be repushed to the CIB
#   Defaults to false
#
# [*update_settle_secs*]
#   When deep_compare is enabled and puppet updates a resource, this
#   parameter represents the number (in seconds) to wait for the cluster to settle
#   after the resource update.
#   Defaults to 600 (seconds)
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
define pacemaker::stonith::fence_rsb (
  $ipaddr         = undef,
  $login          = undef,
  $passwd         = undef,
  $secure         = undef,
  $cmd_prompt     = undef,
  $ipport         = undef,
  $inet4_only     = undef,
  $inet6_only     = undef,
  $passwd_script  = undef,
  $identity_file  = undef,
  $ssh_options    = undef,
  $action         = undef,
  $verbose        = undef,
  $debug          = undef,
  $power_timeout  = undef,
  $shell_timeout  = undef,
  $login_timeout  = undef,
  $power_wait     = undef,
  $delay          = undef,
  $retry_on       = undef,

  $meta_attr      = undef,
  $interval       = '60s',
  $ensure         = present,
  $pcmk_host_list = undef,

  $tries          = undef,
  $try_sleep      = undef,

  $deep_compare       = false,
  $update_settle_secs = 600,
) {
  $ipaddr_chunk = $ipaddr ? {
    undef   => '',
    default => "ipaddr=\"${ipaddr}\"",
  }
  $login_chunk = $login ? {
    undef   => '',
    default => "login=\"${login}\"",
  }
  $passwd_chunk = $passwd ? {
    undef   => '',
    default => "passwd=\"${passwd}\"",
  }
  $secure_chunk = $secure ? {
    undef   => '',
    default => "secure=\"${secure}\"",
  }
  $cmd_prompt_chunk = $cmd_prompt ? {
    undef   => '',
    default => "cmd_prompt=\"${cmd_prompt}\"",
  }
  $ipport_chunk = $ipport ? {
    undef   => '',
    default => "ipport=\"${ipport}\"",
  }
  $inet4_only_chunk = $inet4_only ? {
    undef   => '',
    default => "inet4_only=\"${inet4_only}\"",
  }
  $inet6_only_chunk = $inet6_only ? {
    undef   => '',
    default => "inet6_only=\"${inet6_only}\"",
  }
  $passwd_script_chunk = $passwd_script ? {
    undef   => '',
    default => "passwd_script=\"${passwd_script}\"",
  }
  $identity_file_chunk = $identity_file ? {
    undef   => '',
    default => "identity_file=\"${identity_file}\"",
  }
  $ssh_options_chunk = $ssh_options ? {
    undef   => '',
    default => "ssh_options=\"${ssh_options}\"",
  }
  $action_chunk = $action ? {
    undef   => '',
    default => "action=\"${action}\"",
  }
  $verbose_chunk = $verbose ? {
    undef   => '',
    default => "verbose=\"${verbose}\"",
  }
  $debug_chunk = $debug ? {
    undef   => '',
    default => "debug=\"${debug}\"",
  }
  $power_timeout_chunk = $power_timeout ? {
    undef   => '',
    default => "power_timeout=\"${power_timeout}\"",
  }
  $shell_timeout_chunk = $shell_timeout ? {
    undef   => '',
    default => "shell_timeout=\"${shell_timeout}\"",
  }
  $login_timeout_chunk = $login_timeout ? {
    undef   => '',
    default => "login_timeout=\"${login_timeout}\"",
  }
  $power_wait_chunk = $power_wait ? {
    undef   => '',
    default => "power_wait=\"${power_wait}\"",
  }
  $delay_chunk = $delay ? {
    undef   => '',
    default => "delay=\"${delay}\"",
  }
  $retry_on_chunk = $retry_on ? {
    undef   => '',
    default => "retry_on=\"${retry_on}\"",
  }

  $pcmk_host_value_chunk = $pcmk_host_list ? {
    undef   => '$(/usr/sbin/crm_node -n)',
    default => $pcmk_host_list,
  }

  $meta_attr_value_chunk = $meta_attr ? {
    undef   => '',
    default => "meta ${meta_attr}",
  }

  # $title can be a mac address, remove the colons for pcmk resource name
  $safe_title = regsubst($title, ':', '', 'G')

  Exec<| title == 'wait-for-settle' |> -> Pcmk_stonith<||>

  $param_string = "${ipaddr_chunk} ${login_chunk} ${passwd_chunk} ${secure_chunk} ${cmd_prompt_chunk} ${ipport_chunk} ${inet4_only_chunk} ${inet6_only_chunk} ${passwd_script_chunk} ${identity_file_chunk} ${ssh_options_chunk} ${action_chunk} ${verbose_chunk} ${debug_chunk} ${power_timeout_chunk} ${shell_timeout_chunk} ${login_timeout_chunk} ${power_wait_chunk} ${delay_chunk} ${retry_on_chunk}  op monitor interval=${interval} ${meta_attr_value_chunk}"

  if $ensure != 'absent' {
    ensure_resource('package', 'fence-agents-rsb', { ensure => 'installed' })
    Package['fence-agents-rsb'] -> Pcmk_stonith["stonith-fence_rsb-${safe_title}"]
  }
  pcmk_stonith { "stonith-fence_rsb-${safe_title}":
    ensure             => $ensure,
    stonith_type       => 'fence_rsb',
    pcmk_host_list     => $pcmk_host_value_chunk,
    pcs_param_string   => $param_string,
    tries              => $tries,
    try_sleep          => $try_sleep,
    deep_compare       => $deep_compare,
    update_settle_secs => $update_settle_secs,
  }
}
