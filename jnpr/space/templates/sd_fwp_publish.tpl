{#
  Parameters used:
     - policy_id_list
         A list of policy-id. Each must be integer
#}

<publish>
  <policy-ids>
{%- for policy_id in policy_id_list %}
    <policy-id>{{policy_id}}</policy-id>
{%- endfor %}
  </policy-ids>
</publish>

