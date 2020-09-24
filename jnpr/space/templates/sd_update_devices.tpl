{#
  Parameters used:
     - device_id_list
         A list of device ids. 
     - service_type_list (POLICY | ?)
     - policy_rematch (boolean)
#}
<update-devices>
  <sd-ids>
{%- for device_id in device_id_list %}
    <id>{{device_id}}</id>
{%- endfor %}
  </sd-ids>
  <service-types>
{%- for service_type in service_type_list %}
    <service-type>{{service_type}}</service-type>
{%- endfor %}
  </service-types>
  <update-options>
    <enable-policy-rematch-srx-only>{{policy_rematch}}</enable-policy-rematch-srx-only>
  </update-options>
</update-devices>
