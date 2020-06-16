# frozen_string_literal: true

require 'azurerm_resource'
require 'json'

class AzurermAppServicePlans < AzurermPluralResource
  name 'azurerm_app_service_plans'
  desc 'Verifies settings for a collection of Azure App Service Plans'
  example <<-EXAMPLE
    describe azurerm_app_service_plans( resource_group: 'rg-1' ) do
        it  { should exist }
        its('names') { should include 'myplanname' }
    end
  EXAMPLE

  attr_reader :table, :resource_group

  FilterTable.create
             .register_column(:ids,        field: :id)
             .register_column(:names,      field: :name)
             .register_column(:properties, field: :properties)
             .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil )
    @resource_group = resource_group
    records = management.app_service_plans(resource_group: resource_group)
    return if has_error?(records)

    @table = records
  end

  def to_s
    "Azure App Service Plans RG=#{resource_group}"
  end
end
