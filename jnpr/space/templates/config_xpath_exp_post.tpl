{#
  Parameters used:
     - xpaths
         A list of xpath expressions as strings
     - format
        Can be "xml" or "cli"
#}
{%- if format %}

<expanded-{{format}}-configuration-request>
<xpath-list>
{%- for X in xpaths %}
  <xpath>{{ X }}</xpath>
{%- endfor %}
</xpath-list>
</expanded-{{format}}-configuration-request>

{%- else %}

<expanded-xml-configuration-request>
<xpath-list>
{%- for X in xpaths %}
  <xpath>{{ X }}</xpath>
{%- endfor %}
</xpath-list>
</expanded-xml-configuration-request>

{%- endif %}