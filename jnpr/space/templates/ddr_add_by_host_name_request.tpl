{#-
  Parameters used:
{
    "device_snmp_version": "SNMPV1V2C",
    "device_targets": {
        "device_target": {
            "device_fingerprints": [
                "device_fingerprint": {
                    "fingerprint": "55:77:53:a6:b1:94:45:12:bc:01:9d:b8:2a:8a:0a:b8",
                    "host_name": "test"
                }
            ],
            "device_ssh_credentials": [
                "device_ssh_credential": {
                    "credential_type": "CREDENTIAL_BASED",
                    "keybased": "false",
                    "pass_phrase": "test_phrase",
                    "password": "********",
                    "private_key": "MIIEogIBAAKCAQEAxzybh9VkWiJ0gN0O4o",
                    "username": "root"
                }
            },
            "ip_address": "192.168.1.100"
        }
    },
    "discovery_action_additional_params": {
        "discovery_action_additional_param": {
            "parameter": "import_policy",
            "parameter_value": "false"
        }
    },
    "discovery_profile_name": "IP_Discovery_Profile",
    "sharable": "false",
    "use_nat": "false",
    "use_ping": "false",
    "use_snmp": "false"
}

-#}

<add-device-discovery-rule-by-host-name-request>
     <discovery-profile-name>{{discovery_profile_name}}</discovery-profile-name>
{%- if use_ping %}
     <use-ping>{{use_ping|lower}}</use-ping>
{%- else %}
     <use-ping>false</use-ping>
{%- endif %}
{%- if use_nat %}
     <use-nat>{{use_nat|lower}}</use-nat>
{%- else %}
     <use-nat>false</use-nat>
{%- endif %}
{%- if sharable %}
     <sharable>{{sharable|lower}}</sharable>
{%- else %}
     <sharable>false</sharable>
{%- endif %}
{%- if use_snmp %}
     <use-snmp>{{use_snmp|lower}}</use-snmp>
{%- else %}
     <use-snmp>false</use-snmp>
{%- endif %}
     <device-targets>
{%- for device_target in device_targets %}
           <device-target>
               <host-name>{{device_target.ip_address}}</host-name>
               <device-ssh-credentials total="{{device_target.device_ssh_credentials|count}}">
{%- for device_ssh_credential in device_target.device_ssh_credentials %}
                     <device-ssh-credential>
                         <credential-type>CREDENTIAL_BASED</credential-type>
                         <keybased>{{device_ssh_credential.keybased|lower}}</keybased>
{%- if device_ssh_credential.keybased %}
                         <pass-phrase>{{device_ssh_credential.pass_phrase}}</pass-phrase>
                         <private-key>{{device_ssh_credential.private_key}}</private-key>
{%- else %}
                         <username>{{device_ssh_credential.username}}</username>
                         <password>{{device_ssh_credential.password}}</password>
{%- endif %}
                     </device-ssh-credential>
{%- endfor %}
               </device-ssh-credentials>
{%- if device_target.device_fingerprints|length > 0 %}
               <device-fingerprints total="{{device_target.device_fingerprints|count}}">
{%- for device_fingerprint in device_target.device_fingerprints %}
                     <device-fingerprint>
                         <host-name>{{device_fingerprint.host_name}}</host-name>
                         <fingerprint>{{device_fingerprint.fingerprint}}</fingerprint>
                     </device-fingerprint>
               </device-fingerprints>
{%- endfor %}
{%- endif %}
           </device-target>
{%- endfor %}
     </device-targets>
     <device-snmp-version>{{device_snmp_version}}</device-snmp-version>
{%- if device_snmp_version == "SNMPV3"  %}
    <device-snmp-details>
        <user-name>{{device_snmp_details.user_name}}</user-name>
	<snmp-auth-type>{{device_snmp_details.snmp_auth_type}}</snmp-auth-type>
	<authentication-password>{{device_snmp_details.authentication_password}}<authentication-password>
	<privacy-type>{{device_snmp_details.privacy_type}}</privacy-type>
	<privacy-password>{{device_snmp_details.privacy_password}}</privacy-password>
    </device-snmp-details>
{%- else %}
{%- if device_snmp_version == "SNMPV1V2C"  %}
{%- if device_snmp_details.snmpv1v2c_community %}
     <device-snmp-details>
         <snmpv1v2c-community>{{device_snmp_details.snmpv1v2c_community}}</snmpv1v2c-community>
     </device-snmp-details>
{%- endif %}
{%- endif %}
{%- endif %}

     <discovery-action-additional-params>
           <discovery-action-additional-param>
               <parameter>import-policy</parameter>
               <parameter-value>false</parameter-value>
           </discovery-action-additional-param>
     </discovery-action-additional-params>
{%- if discovery_action_additional_params %}

{%- endif %}
</add-device-discovery-rule-by-host-name-request>

