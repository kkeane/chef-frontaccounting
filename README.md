# frontaccounting-cookbook

Installes FrontAccounting (http://www.frontaccounting.com)

## Supported Platforms

CentOS. Other platforms may work with different attributes

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['baseurl']</tt></td>
    <td>String</td>
    <td>The URL file path under which the accounting package should be available</td>
    <td><tt>/accounting</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['documentroot']</tt></td>
    <td>String</td>
    <td>The directory in the file system where the root of the Web server is located. The baseurl will be added later</td>
    <td><tt>/var/www/html</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['servername']</tt></td>
    <td>String</td>
    <td>The server name (for virtual hosting)</td>
    <td><tt>The machine's FQDN</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['fileuser']</tt></td>
    <td>String</td>
    <td>The user name who should own the files in the application</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['filegroup']</tt></td>
    <td>String</td>
    <td>The group name who should own the files in the application</td>
    <td><tt>apache</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['company']</tt></td>
    <td>Array</td>
    <td>Information about each company in the Frontaccounting database. Note that
the password is not included here; you must pass the passwords using node.run_state
instead.</td>
    <td><tt>[0]['companyname'] = "Sample Company Inc."<br/>
            [0]['dbhost'] = "localhost"<br/>
            [0]['dbname'] = "frontacc"<br/>
            [0]['dbuser'] = "frontacc"<br/></tt></td>
  </tr>
</table>

## Usage

### frontaccounting::default

Set up a Web server, for instance using the httpd cookbook.

Set any attributes you need as non-default. Specify the database password using the
node.run_state[:frontaccounting_dbpw] mechanism:

If all companies use the same password, use this:

<code>node.run_state[:frontaccounting_dbpw] = 'password'</code>

If the companies need different database passwords, pass an array. The index for each
password must match the index for the corresponding company information in the
node['frontaccounting']['company'] attribute array.

<code>node.run_state[:frontaccounting_dbpw] = [ 'password1', 'password2' ]</code>

Include `frontaccounting` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[frontaccounting::default]"
  ]
}
```

## License and Authors

Author:: North County Tech Center, LLC (<kkeane@4nettech.com>)
License:: GPLv3

