name 'dp_jenkins_master'
maintainer 'Gannett Co., Inc'
maintainer_email 'paas-delivery@gannett.com'
license ' Copyright (c) 2016 Gannett Co., Inc, All Rights Reserved.'
description 'Installs/Configures dp_jenkins_master'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'gdp-base-linux', '= 3.0.1'
depends 'java', '= 1.35.0'
depends 'tomcat', '= 1.0.1'
depends 'python', '= 1.6.0'
depends 'nginx', '= 2.7.8'
depends 's3cmd', '= 0.2.0'
depends 'datadog', '= 2.1.0'
depends 'jenkins', '= 3.4.0'
depends 'datadog_support', '= 3.0.1'

supports 'centos'

source_url 'https://github.com/GannettDigital/chef-dp_jenkins_master'
issues_url 'https://github.com/GannettDigital/chef-dp_jenkins_master/issues'
