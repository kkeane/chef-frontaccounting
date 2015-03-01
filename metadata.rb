name             'frontaccounting'
maintainer       'North County Tech Center, LLC'
maintainer_email 'kkeane@4nettech.com'
license          'GNU Public License 3.0'
description      'Installs/Configures frontaccounting'
long_description 'Installs/Configures the accounting package FrontAccounting.'
version          '1.1.0'

%w{ centos }.each do |os|
  supports os
end

depends 'php'
depends 'mysql', '>= 6'

