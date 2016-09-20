#
# Cookbook Name:: dp_jenkins_master
# Recipe:: default
#
# Copyright (c) 2016 Gannett Co., Inc, All Rights Reserved.

fail if node['platform'] == 'windows'

include_recipe 'gdp-base-linux'
include_recipe 'jenkins::default'
include_recipe 'jenkins::nginx'
include_recipe 'nginx::http_stub_status_module'
include_recipe 'jenkins::plugins'
include_recipe 'jenkins::ldap'
include_recipe 'jenkins::backup'
include_recipe 'datadog::nginx'
include_recipe 'datadog::jenkins'
include_recipe 'datadog::process'
include_recipe 'datadog_support::jenkins-backup-check'
include_recipe 'jenkins::swarm-master'