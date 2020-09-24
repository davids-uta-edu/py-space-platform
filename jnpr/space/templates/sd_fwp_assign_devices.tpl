{#
  Parameters used:
     deleted_devices :
         A list of devices.
       - name :
         moid :
     added_devices :
       - moid
       
#}

<assign-devices>
{%- if (deleted_devices and deleted_devices|length() > 0) %} 
  <deleted-devices>
{%- for device in deleted_devices %}
    <deleted-device>
      <name>{{device.name}}</name>
      <moid>{{device.moid}}</moid>
    </deleted-device>
{%- endfor %}
  </deleted-devices>
{%- endif %}
{%- if (added_devices and added_devices|length() > 0) %} 
  <added-devices>
{%- for device in added_devices %}
    <added-device>
      <moid>{{device.moid}}</moid>
    </added-device>
{%- endfor %}
  </added-devices>
{%- endif %}
</assign-devices>
