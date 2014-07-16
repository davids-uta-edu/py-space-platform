import logging.config
import ConfigParser

from jnpr.space.platform.core import rest, xmlutil

class TestDevices:

    def setup_class(self):
        # Initialize logging
        logging.config.fileConfig('./logging.conf')

        # Extract Space URL, userid, password from config file
        config = ConfigParser.RawConfigParser()
        config.read("./test.conf")
        url = config.get('space', 'url')
        user = config.get('space', 'user')
        passwd = config.get('space', 'passwd')

        # Create a Space REST end point
        self.space = rest.Space(url, user, passwd)

    def test_devices_expanded_config_post(self):
        devices_list = self.space.device_management.devices.get(
                            filter_={'managedStatus': 'In Sync'},
                            sortby=['name', 'platform'])
        assert len(devices_list) > 0, "Not enough devices on Space"

        for d in devices_list:
            exp = d.configurations.expanded.post(xpaths=['/configuration/version',
            '/configuration/interfaces/interface[starts-with(name, "ge-")]'])

            c = exp.configuration
            if c.interface is not None:
                for i in c.interface:
                    if isinstance(i.name, basestring):
                        print i.name
                        assert i.name.startswith('ge-'), \
                            "Intf name %s failed check" % i.name
                    else:
                        print i.name.data
                        assert i.name.data.startswith('ge-'), \
                            "Intf name %s failed check" % i.name.data

            assert c.version[:7] == d.OSVersion[:7]

    def test_devices_raw_config(self):
        devices_list = self.space.device_management.devices.get(
                            filter_={'managedStatus': 'In Sync'})
        assert len(devices_list) > 0, "Not enough devices on Space"

        for d in devices_list:
            raw = d.configurations.raw.get()
            assert raw
            raw_config = xmlutil.xml2obj(raw.configuration)

            assert raw_config.version[:7] == d.OSVersion[:7]

            if raw_config.groups is not None:
                for g in raw_config.groups:
                    print "Found config group %s on device %s" % (g.name, d.name)

    def test_devices_raw_config_post(self):
        devices_list = self.space.device_management.devices.get(
                            filter_={'managedStatus': 'In Sync'})
        assert len(devices_list) > 0, "Not enough devices on Space"

        for d in devices_list:
            raw = d.configurations.raw.post(xpaths=['/configuration/version',
            '/configuration/interfaces/interface[starts-with(name, "ge-")]'])

            c = raw.configuration
            if c.interface is not None:
                for i in c.interface:
                    print i.name
                    assert i.name.startswith('ge-')

            assert c.version[:7] == d.OSVersion[:7]

    def test_devices_expanded_config(self):
        devices_list = self.space.device_management.devices.get(
                            filter_={'managedStatus': 'In Sync'})
        assert len(devices_list) > 0, "Not enough devices on Space"

        for d in devices_list:
            exp = d.configurations.expanded.get()
            assert exp
            exp_config = xmlutil.xml2obj(exp.configuration)

            assert exp_config.groups is None

            assert exp_config.version[:7] == d.OSVersion[:7]

    def test_devices_configs(self):
        devices_list = self.space.device_management.devices.get(
                            filter_={'managedStatus': 'In Sync'})
        assert len(devices_list) > 0, "Not enough devices on Space"

        for d in devices_list:
            configs = d.configurations.get()
            assert len(configs) == 2
            for c in configs:
                xml_config = c.get()
                xml_config = xmlutil.xml2obj(xml_config.configuration)
                assert xml_config.version[:7] == d.OSVersion[:7]

    def test_devices_scripts(self):
        devices_list = self.space.device_management.devices.get()
        assert len(devices_list) > 1, "Not enough devices on Space"

        for d in devices_list:
            try:
                scripts = d.associated_scripts.get()
                assert len(scripts) > 0
                for s in scripts:
                    assert s.script_device_association.device_name == d.name
            except:
                pass

    def test_devices_softwares(self):
        devices_list = self.space.device_management.devices.get()
        assert len(devices_list) > 1, "Not enough devices on Space"

        for d in devices_list:
            try:
                sws = d.associated_softwares.get()
                assert len(sws) >= 0
            except:
                pass

    def test_devices_change_requests(self):
        devices_list = self.space.device_management.devices.get()
        assert len(devices_list) > 1, "Not enough devices on Space"

        for d in devices_list:
            crs = d.change_requests.get()
            assert len(crs) >= 0
            for cr in crs:
                assert cr.deviceId == d.key