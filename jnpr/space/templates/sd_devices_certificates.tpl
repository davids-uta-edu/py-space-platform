{#
  Parameters used:
     - device_id
         A list of device ids (integer)
     - auth_method (PRESHARED_KEY| ?)
#}

<certificates-for-devices-request>
    <device-id-list>
{% for device_id in device_id_list %}
        <ids>{{device_id}}</ids>
i(% endfor %}
    </device-id-list>
    <auth-method>{{auth_method}}</auth-method>
</certificates-for-devices-request>
