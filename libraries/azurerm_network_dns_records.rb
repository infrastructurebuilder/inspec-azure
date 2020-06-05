# frozen_string_literal: true

require 'azurerm_resource'
require 'json'

class AzurermNetworkDnsRecords < AzurermPluralResource
  name 'azurerm_network_dns_records'
  desc 'Verifies settings for a collection of Azure DNS Records for a given Zone of a given type'
  example <<-EXAMPLE
    describe azurerm_network_dns_records( resource_group: 'rg-1', zone_name: 'myzone' ) do
        it  { should exist }
    end
  EXAMPLE

  attr_reader :table, :record_type

  FilterTable.create
             .register_column(:ids,        field: :id)
             .register_column(:names,      field: :name)
             .register_column(:properties, field: :properties)
             .register_column(:types,      field: :record_type)
             .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil, zone_name:, record_type: )
    @record_type = record_type
    dns_records = management.dns_records(resource_group: resource_group, zone_name: zone_name, record_type: record_type)
#    puts "\n\ndns_records is \n#{dns_records}"
    return if has_error?(dns_records)

    @table = dns_records
  end

  def to_s
    "Azure DNS Records type #{record_type}"
  end
end
