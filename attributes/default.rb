default['java']['jdk_version'] =  '7'
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = 'true'

default['tomcat']['base_version'] = 7
# Begin code smell
suffix = ''
default['tomcat']['base_instance'] = "tomcat#{suffix}"
default['tomcat']['user'] = 'tomcat'
default['tomcat']['group'] = 'tomcat'
default['tomcat']['home'] = "/usr/share/tomcat#{suffix}"
default['tomcat']['base'] = "/usr/share/tomcat#{suffix}"
default['tomcat']['config_dir'] = "/etc/tomcat#{suffix}"
default['tomcat']['log_dir'] = "/var/log/tomcat#{suffix}"
default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{suffix}/temp"
default['tomcat']['work_dir'] = "/var/cache/tomcat#{suffix}/work"
default['tomcat']['context_dir'] = "#{node['tomcat']['config_dir']}/Catalina/localhost"
default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{suffix}/webapps"
default['tomcat']['keytool'] = 'keytool'
default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
default['tomcat']['endorsed_dir'] = "#{node['tomcat']['lib_dir']}/endorsed"
default['tomcat']['packages'] = ["tomcat#{suffix}"]
default['tomcat']['deploy_manager_packages'] = ["tomcat#{suffix}-admin-webapps"]
# End code smell

memory = node['memory']['total'].gsub('kB', '').to_i
default['tomcat']['xmx'] = ((memory * 0.5) / 1024).to_i
default['tomcat']['xms'] = (node['tomcat']['xmx'] / 2).to_i

normal['tomcat']['java_options'] =
  "-server -Xms#{node['tomcat']['xms']}m -Xmx#{node['tomcat']['xmx']}m "\
  '-DJENKINS_HOME=/opt/jenkins ' \
  '-Djava.awt.headless=true -Dcom.sun.management.jmxremote ' \
  '-Dcom.sun.management.jmxremote.authenticate=false ' \
  '-Dcom.sun.management.jmxremote.ssl=false ' \
  '-Dcom.sun.management.jmxremote.port=9999 ' \
  '-Duser.timezone=GMT-5 -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled ' \
  '-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses' \
  '-Djenkins.install.runSetupWizard=false'

normal['python']['version'] = '2.7.10-1.el7.centos.gd'
normal['python']['install_method'] = 'custom-package'

normal['nginx']['default_site_enabled'] = false
normal['opsmatic']['groups'] = ['jenkins']

normal['jenkins']['tomcat_service'] = 'tomcat'
normal['jenkins']['install_dir'] = '/usr/share/tomcat/webapps'
normal['jenkins']['site-name'] = 'dp-jenkins-master.tools.gannettdigital.com'
normal['jenkins']['work_dir'] = '/opt/jenkins'
normal['jenkins']['user'] = 'tomcat'
normal['jenkins']['group'] = 'tomcat'
normal['jenkins']['home'] = '/usr/share/tomcat'
normal['jenkins']['iam_user'] = 'chef-jenkins'
normal['jenkins']['plugins'] = [
  'ant',
  'ansicolor',
  'antisamy-markup-formatter',
  'aws-device-farm',
  'bouncycastle-api',
  'build-timeout',
  'bulk-builder',
  'credentials',
  'credentials-binding',
  'cvs',
  'datadog',
  'external-monitor-job',
  'git',
  'git-client',
  'github',
  'github-api',
  'ghprb',
  'htmlpublisher',
  'icon-shim',
  'javadoc',
  'jobConfigHistory',
  'junit',
  'ldap',
  'leastload',
  'mail-watcher-plugin',
  'mailer',
  'mapdb-api',
  'matrix-auth',
  'matrix-project',
  'maven-plugin',
  'naginator',
  'pam-auth',
  'parameterized-trigger',
  'performance',
  'plain-credentials',
  'ruby-runtime',
  'rvm',
  'scm-api',
  'script-security',
  'slack',
  'ssh',
  'ssh-agent',
  'ssh-slaves',
  'ssh-credentials',
  'structs',
  'subversion',
  'swarm',
  'template-project',
  'thinBackup',
  'token-macro',
  'workflow-aggregator',
  'workflow-multibranch',
  'workflow-scm-step',
  'workflow-step-api',
  'ws-cleanup'
]
normal['jenkins']['backup']['user'] = 'tomcat'
normal['jenkins']['backup']['method'] = 's3'
normal['jenkins']['backup']['location'] = 's3://gdp-dev-ops'
normal['jenkins']['backup']['directory'] = 'dp-jenkins-master'
normal['jenkins']['backup']['key_path'] = '~/.ssh/id_rsa'

normal['splunk']['client-name']['production'] = 'GD-AWS-DEVOPS-JENKINS-LX'
normal['splunk']['client-name']['staging'] = 'GD-AWS-DEVOPS-JENKINS-LX'
normal['splunk']['client-name']['development'] = 'GD-AWS-DEVOPS-JENKINS-LX'
normal['git']['prefix'] = '/usr'
normal['datadog']['jenkins']['instances'] = [
  {
    'name' => 'dp-jenkins-master',
    'home' => '/opt/jenkins'
  }
]
normal['datadog']['nginx']['instances'] = [
  {
    'nginx_status_url' => 'http://localhost:8090/nginx_status/'
  }
]
normal['datadog']['tomcat']['instances'] = [
  {
    'host' => 'localhost',
    'port' => 9999,
    'name' => 'dp-jenkins-master'
  }
]
normal['datadog']['process']['instances'] = [
  {
    'name' => 'nginx',
    'search_string' => ['nginx'],
    'exact_match' => 'False'
  },
  {
    'name' => 'tomcat',
    'search_string' => ['tomcat'],
    'exact_match' => 'False'
  }
]
default['s3cmd']['has_data_bag'] = true
default['s3cmd']['data_bag_name'] = 's3cmd'
default['s3cmd']['data_bag_item'] = 'dp-jenkins-master'

normal['splunk']['cookbook'] = 'chef-splunk'
default['splunk']['user'] = {
  'username' => 'splunk',
  'comment'  => 'Splunk Server',
  'home'     => '/opt/splunkforwarder',
  'shell'    => '/bin/bash',
  'uid'      => 396
}
normal['splunk']['apps'] += [
  { name: 'jenkinsslavelogs_inputs', templates: ['inputs.conf'], template_cookbook: 'splunk_support' },
  { name: 'jenkinsmasterlogs_inputs', templates: ['inputs.conf'], template_cookbook: 'splunk_support' }
]

default['jenkins']['swarm']['port'] = 9000