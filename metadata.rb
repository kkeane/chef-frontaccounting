name             'frontaccounting'
maintainer       'North County Tech Center, LLC'
maintainer_email 'kkeane@4nettech.com'
license          'GNU Public License 3.0'
description      'Installs/Configures frontaccounting'
long_description 'Installs/Configures the accounting package FrontAccounting.'
version          '1.0.0'

%w{ centos }.each do |os|
  supports os
end

depends 'php'
# We don't actually need the mysql cookbook, but the php cookbook
# includes it, and version 6.0.3 will cause a conflict that causes
# httpd to be misconfigured.
depends 'mysql', '< 6.0'

