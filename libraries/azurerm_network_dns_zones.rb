# frozen_string_literal: true

require 'azurerm_resource'
require 'json'

class AzurermNetworkDnsZones < AzurermPluralResource
  name 'azurerm_network_dns_zones'
  desc 'Verifies settings for a collection of Azure DNS Zones'
  example <<-EXAMPLE
    describe azurerm_network_dns_zones do
        it  { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:ids,        field: :id)
             .register_column(:names,      field: :name)
             .register_column(:locations,  field: :location)
             .register_column(:properties, field: :properties)
             .register_column(:tags,       field: :tag)
             .register_column(:types,      field: :type)
             .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil)
    dns_zones = management.dns_zones(resource_group)
    return if has_error?(dns_zones)

    @table = dns_zones
  end

  def to_s
    'Azure DNS Zones'
  end
end
