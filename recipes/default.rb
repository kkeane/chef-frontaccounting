#
# Cookbook Name:: frontaccounting
# Recipe:: default
#
# Copyright (C) 2014 North County Tech Center, LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

include_recipe "php"

passwords = Chef::EncryptedDataBagItem.load("passwords", "servers")

downloadurl=node['frontaccounting']['downloadurl']
version=node['frontaccounting']['version']
minorversion=node['frontaccounting']['minorversion']
downloadfile="frontaccounting-#{version}.#{minorversion}.tar.gz"

baseurl=node['frontaccounting']['baseurl']
documentroot=node['frontaccounting']['documentroot']
basedir="#{documentroot}#{baseurl}"
fileuser=node['frontaccounting']['fileuser']
filegroup=node['frontaccounting']['filegroup']

directory basedir do
  recursive true
end

fqdn = node['frontaccounting']['servername']

bash "unpack frontaccounting" do
  action :nothing
  code "
tar xfz #{Chef::Config[:file_cache_path]}/#{downloadfile} -C #{basedir} --strip-components=1
chown -R #{fileuser}:#{filegroup} #{basedir}
"
end

remote_file "#{Chef::Config[:file_cache_path]}/#{downloadfile}" do
  action :create_if_missing
  source downloadurl
  notifies :run, "bash[unpack frontaccounting]", :immediate
  backup 0
end

# Clean up a few files and directories that are not needed and might constitute security
# concerns.
%w{ install.html update.html CHANGELOG.txt config.default.php }.each do |f|
  file "#{basedir}/#{f}" do
    action :delete
  end
end

# The install directory must be deleted for security reasons.
directory "#{basedir}/install" do
  action :delete
  recursive true
end

# Configure FrontAccounting. Once these files are created, don't touch them
# because FrontAccounting may have updated them.
%w{ config.php installed_extensions.php }.each do |f|
  template "#{basedir}/#{f}" do
    action :create_if_missing
    source "#{f}.erb"
    owner fileuser
    group filegroup
    mode  "0440"
  end
end


companies=node['frontaccounting']['company']

passwords = node.run_state[:frontaccounting_dbpw]

# Insert the password into the companydata
companydata = companies.map do |index,company|
  # puts company
  # puts index
  new = {}
  new['index'] = index
  %w{ companyname dbhost dbname dbuser }.each do |attrname|
    new[attrname] = company[attrname]
  end
  new['dbpassword'] = passwords.is_a?(Array) ? passwords[index] : passwords
  new
end

template "#{basedir}/config_db.php" do
  source "config_db.php.erb"
  owner fileuser
  group filegroup
  mode  "0440"
  variables(
    :companydata => companydata
  )
end

