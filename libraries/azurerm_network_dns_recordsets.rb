# frozen_string_literal: true

require 'azurerm_resource'
require 'json'

class AzurermNetworkDnsRecordsets < AzurermPluralResource
  name 'azurerm_network_dns_recordsets'
  desc 'Verifies settings for a collection of Azure DNS Recordsets'
  example <<-EXAMPLE
    describe azurerm_network_dns_recordsets do
        it  { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:ids,        field: :id)
             .register_column(:names,      field: :name)
             .register_column(:properties, field: :properties)
             .register_column(:types,      field: :type)
             .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil, zone_name:    )
    dns_recordsets = management.dns_recordsets(resource_group, zone_name)
#    puts "Recordsets is \n#{dns_recordsets}"
    return if has_error?(dns_recordsets)

    @table = dns_recordsets
  end

  def to_s
    'Azure DNS Recordsets'
  end
end
