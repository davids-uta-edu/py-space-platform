{#
  Parameters used:
     - name
         An address object to be created.
         It must begin with an alphanumeric character and cannot exceed 63
         characters. Dashes and underscores are allowed.
     - address_type
         An address type of the object to be created.
         Available options - IPADDRESS, GROUP, RANGE, NETWORK, WILDCARD, DNS,
         POLYMORPHIC, DYNAMIC_ADDRESS_GROUP, Z_TYPE_IMPORT
     - members (optional)
         A list of member objects for address_type GROUP.
     - host_name (optional)
         A FQDN name that be resolved by DNS.
         It must begin with an alphanumeric character and cannot exceed 63
         characters. Dashes and underscores are allowed.
     - description (optional)
         A description for the address; as useful as possible for all admins.
         Maximum length is 1,024 characters.
     - ip_address (optional)
         A valid IPv4 or IPv6 host IP address.
     - address_version (optional)
         IP address version of the object.
         Available options - IPV4, IPV6, MIXED
     - definition_type
         Junos Security Director address definition type.
         Available options - HIDDEN, PREDEFINED, CUSTOM, ALL
#}

<address>
   <name>{{name}}</name>
   {%- if address_type == 'GROUP' %}
   <members>
     {%- for m in members %}
     <member>
       <name>{{member_name}}</name>
       <address-type>{{member_address_type}}</address-type>
       <host-name>{{member_host_name}}</host-name>
       <description>{{member_description}}</description>
       <ip-address>{{member_ip_address}}</ip-address>
       <id>{{member_id}}</id>
     </member>
     {%- endfor %}
   </members>
   {% endif -%}
   <address-type>{{address_type}}</address-type>
   {%- if address_type == 'IPADDRESS' %}
     <ip-address>{{ip_address}}</ip-address>
     <address-version>{{address_version}}</address-version>
   {% endif -%}
   <description>{{description}}</description>
   {%- if address_type == 'DNS' %}
     <host-name>{{host_name}}</host-name>
   {% endif -%}
   <definition-type>{{definition_type}}</definition-type>
</address>
