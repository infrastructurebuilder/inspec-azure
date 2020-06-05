# frozen_string_literal: true

require 'azurerm_resource'

class AzurermNetworkDnsRecord < AzurermSingularResource
  name 'azurerm_network_dns_record'
  desc 'Verifies settings for an Azure Network DNS Zone'
  example <<-EXAMPLE
    describe resource_group: 'rg-1',  zone_name: 'myzonename', record_type: 'A' do
      it { should exist }
      its('ipv4addresses') { should contain '22.332.23123.2323232' }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    type
    properties
    tags
    etag
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, zone_name: , record_type:, name: '@')
    @record_type = record_type
    @name = name
    @resource_group = resource_group
    @zone_name = zone_name
    dns_records = management.dns_records(resource_group: resource_group, zone_name: zone_name, record_type: record_type )
    return if has_error?(dns_records)
    recs = dns_records.select { |d| d.name == name }
    if recs.length == 1
      assign_fields(ATTRS, recs[0])
      @exists = true
    end
  end

  def type2
    type.gsub("Microsoft.Network/dnszones/",'')
  end

  def ipv4addresses
      type2 =='A' ?  properties.ARecords.collect { |r| r.ipv4Address }  : nil
  end

  def fqdn
      properties.fqdn || nil
  end

  def TTL
    properties.TTL || nil
  end

  def ipv6addresses
    type2 =='AAAA' ?  properties.AAAARecords.collect { |r| r.ipv6Address }  : nil
  end

  def caarecords
    type2 =='CAA' ? properties.caaRecords : nil
  end
  def cname
    type2 =='CNAME' ? properties.CNAMERecord.cname : nil
  end
  def exchanges
    type2 =='MX' ? properties.MXRecords.sort_by { |r| r.preference }.collect { |r| r.exchange } : nil

  end
  def nsdnames
    type2 =='NS' ? properties.NSRecords.collect {|r| r.nsdname } : nil
  end
  def ptrdnames
    type2 =='PTR' ? properties.PTRRecords.collect {|r| r.ptrdname } : nil
  end
  def email
    type2 =='SOA' ? properties.SOARecord.email : nil
  end
  def expireTime
    type2 =='SOA' ? properties.SOARecord.expireTime : nil
  end
  def host
    type2 =='SOA' ? properties.SOARecord.host : nil
  end
  def minimumTTL
    type2 =='SOA' ? properties.SOARecord.minimumTTL : nil
  end
  def refreshTime
    type2 =='SOA' ? properties.SOARecord.refreshTime : nil
  end
  def retryTime
    type2 =='SOA' ? properties.SOARecord.retryTime : nil
  end
  def serialNumber
    type2 =='SOA' ? properties.SOARecord.serialNumber : nil
  end
  def srvrecords
    type2 =='SRV' ? properties.SRVRecords  : nil
  end

  def txtvalues
    type2 =='TXT' ? properties.TXTRecords.collect {|r| r.value} : nil
  end

  def to_s
    "Azure DNS record: #{name}/#{type2}"
  end
end
