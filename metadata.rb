name             'frontaccounting'
maintainer       'North County Tech Center, LLC'
maintainer_email 'kkeane@4nettech.com'
license          'GNU Public License 3.0'
description      'Installs/Configures frontaccounting'
long_description 'Installs/Configures the accounting package FrontAccounting.'
version          '1.0.1'

%w{ centos }.each do |os|
  supports os
end

depends 'php'
# The 6.0 mysql cookbook has some breaking changes that the frontaccounting
# cookbook does not (yet) account for.
depends 'mysql', '< 6.0'

