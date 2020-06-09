# frozen_string_literal: true

require 'azurerm_resource'

class AzurermApiManagementService < AzurermSingularResource
  name 'azurerm_api_management_service'
  desc 'Verifies settings for an Azure Network DNS Zone'
  example <<-EXAMPLE
    describe azurerm_api_management_service(resource_group: 'rg-1',  name: 'myservicename' ) do
      it { should exist }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    type
    publicIpAddresses
    privateIpAddresses
    gatewayUrl
    gatewayRegionalUrl
    tags
    etag
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name:)
    @name = name
    @resource_group = resource_group
    apims = management.api_management_service(resource_group: resource_group, service_name: name)
    return if has_error?(apims)
    assign_fields(ATTRS, apims)
    @exists = true
  end

  def to_s
    "Azure API Management Service : #{name}"
  end

end
