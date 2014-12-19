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
    <td><tt>['frontaccounting']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### frontaccounting::default

Set up a Web server, for instance using the httpd cookbook.

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

