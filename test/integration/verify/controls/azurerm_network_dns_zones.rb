resource_group = input('resource_group', value: nil)
dns_zone = input('dns_zone', value: nil)
dns_zone_recordsets_count = input('dns_zone_recordsets_count',value:nil)


control 'azurerm_network_dns_zone(s)' do

  describe azurerm_network_dns_zones(resource_group: resource_group).where(name: dns_zone) do
    it { should exist }
  end

  describe azurerm_network_dns_zone(resource_group: resource_group,  name: dns_zone) do
    it { should exist }
    its('numberOfRecordSets') { should eq dns_zone_recordsets_count }
    its('zoneType') { should eq 'Public' }
  end
end
