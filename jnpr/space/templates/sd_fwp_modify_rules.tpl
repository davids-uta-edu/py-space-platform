{#
  Parameters used:
     - device_id_list
         A list of devices. Each must have href set.
     - service_type (POLICY | ?)
     - rematch_srx_only (boolean)
#}
<modify-rules>
  <edit-version>{{edit_version}}</edit-version>
  <policy-id>{{policy_id}}</policy-id>
  <added-rules>
{% for rule in added_rules %}
    <added-rule>
      <serial-number>{{rule.serial_number}}</serial-number>
      <name>{{rule.name}}</name>
{% if (rule.source_zones and len(rule.source_zones) > 0) %}
      <source-zones>
{% for src_zone in rule.source_zones %}
        <source-zone>
          <name>untrust</name>
          <zone-type>ZONE</zone-type>
          <default-value/>
        </source-zone>
{% endfor %}
      </source-zones>
{% endif %}

{% if (rule.source_address and len(rule.source_address) > 0) %}
      <source-addresses>
{% for src_addr in rule.source_address %}
        <source-address>
          <id>{{src_addr.id}}</id>
          <name>{{src_addr.name}}</name>
          <address-type>{{src_addr.type}}</address-type>
        </source-address>
{% endfor %}
      </source-addresses>
{% endif %}

      <source-identities>
        <source-identity>Authenticated-User</source-identity>
      </source-identities>

      <destination-zones>
        <destination-zone>
          <name>VPN</name>
          <zone-type>ZONE</zone-type>
        </destination-zone>
      </destination-zones>

      <destination-addresses>
        <destination-address>
          <id>1016100</id>
          <name>10.159.3.0/24</name>
          <address-type>NETWORK</address-type>
        </destination-address>
      </destination-addresses>

      <services>
        <service>
          <id>98674</id>
          <name>apple-ichat</name>
        </service>
      </services>

      <action>PERMIT</action>
      <vpn-tunnel-refs/>

      <application-signature-type>BLACKLIST</application-signature-type>
      <application-signatures>
        <application-signature>
          <id>3792</id>
          <name>163</name>
        </application-signature>
        <application-signature>
          <id>5502</id>
          <name>2CH</name>
        </application-signature>
      </application-signatures>

      <rule-profile>
        <profile-type>INHERITED</profile-type>
      </rule-profile>
      <ips-mode>BASIC</ips-mode>
      <ips-enabled>false</ips-enabled>
      <scheduler>
        <id>98969</id>
        <name>sc5</name>
      </scheduler>
      <description>desc</description>
      <custom-column>
        <custom-column-value id="1016232">asd</custom-column-value>
      </custom-column>

      <edit-version>5</edit-version>
      <definition-type>CUSTOM</definition-type>
      <rule-group-type>CUSTOM</rule-group-type>
      <rule-group-id>1081363</rule-group-id>
      <rule-type>RULE</rule-type>
      <rule-order>0</rule-order>
      <policy-name>GroupPolicy</policy-name>
      <enabled>true</enabled>
    </added-rule>
{% endfor %}
  </added-rules>
</modify-rules>

