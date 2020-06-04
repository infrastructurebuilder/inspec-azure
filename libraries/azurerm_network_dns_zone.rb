# frozen_string_literal: true

require 'azurerm_resource'

class AzurermNetworkDnsZone < AzurermSingularResource
  name 'azurerm_network_dns_zone'
  desc 'Verifies settings for an Azure Network DNS Zone'
  example <<-EXAMPLE
    describe azurerm_network_dns_zone(resource_group: 'rg-1', name: 'myzonename') do
      it { should exist }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    type
    properties
    tags
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name: nil)
<<<<<<< HEAD
    @name = name
    @resource_group = resource_group
    dns_zone = management.dns_zone(resource_group, name)
#    puts "dns_zone is #{dns_zone}"
=======
    puts "Name is #{name}"
    puts "RG is #{resource_group}"
    @name = name
    @resource_group = resource_group
    dns_zone = management.dns_zone(resource_group, name)
    puts "dns_zone is #{dns_zone}"
>>>>>>> cee17b8... First try at dns zone
    return if has_error?(dns_zone)

    assign_fields(ATTRS, dns_zone)

    @exists = true
  end

  def numberOfRecordSets
    properties.numberOfRecordSets || nil
  end

  def zoneType
    properties.zoneType
  end

  def to_s
    "Azure DNS Zone: #{name}"
  end
end
