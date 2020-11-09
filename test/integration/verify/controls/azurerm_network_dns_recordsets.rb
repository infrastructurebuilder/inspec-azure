resource_group = input('resource_group', value: nil)
dns_zone = input('dns_zone', value: nil)
dns_zone_recordsets = input('dns_zone_recordsets',value: nil)
dns_arec_target = input('dns_arec_target' ,value: nil)


control 'azurerm_network_dns_record(s)' do

  describe azurerm_network_dns_record(resource_group: resource_group,  zone_name: dns_zone, record_type: 'A') do
    it { should exist }
    its('ipv4addresses') { should contain dns_arec_target }
  end
  describe azurerm_network_dns_records(resource_group: resource_group,  zone_name: dns_zone)  do
    it { should exist }
  end

end
