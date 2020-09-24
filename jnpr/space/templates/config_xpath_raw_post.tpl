{#
  Parameters used:
     - xpaths
         A list of xpath expressions as strings
     - format
        Can be "xml" or "cli"
#}
{%- if format %}

<raw-{{format}}-configuration-request>
<xpath-list>
{%- for X in xpaths %}
  <xpath>{{ X }}</xpath>
{%- endfor %}
</xpath-list>
</raw-{{format}}-configuration-request>

{%- else %}

<raw-xml-configuration-request>
<xpath-list>
{%- for X in xpaths %}
  <xpath>{{ X }}</xpath>
{%- endfor %}
</xpath-list>
</raw-xml-configuration-request>

{%- endif %}