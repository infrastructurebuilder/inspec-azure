# frozen_string_literal: true

require 'azurerm_resource'

class AzurermApiManagementService < AzurermSingularResource
  name 'azurerm_api_management_service'
  desc 'Verifies settings for an Azure API Management Service'
  example <<-EXAMPLE
    describe azurerm_api_management_service(resource_group: 'rg-1',  name: 'myservicename' ) do
      it { should exist }
      its('publisherEmail') { should cmp 'jeff@jeff.com' }
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

  def initialize(resource_group: nil, service_name: nil )
    @name = service_name
    @resource_group = resource_group
    apims = management.api_management_service( resource_group, service_name)
    return if has_error?(apims)
    assign_fields(ATTRS, apims)
    @exists = true
  end

  def publisherName
    properties['publisherName'] || nil
  end

  def publisherEmail
    properties['publisherEmail'] || nil
  end

  def publicIpAddresses
    properties['publicIpAddresses'] || nil
  end

  def privateIpAddresses
    properties['privateIpAddresses'] || nil
  end

  def gatewayUrl
    properties['gatewayUrl'] || nil
  end

  def gatewayRegionalUrl
    properties['gatewayRegionalUrl'] || nil
  end

  def notificationSenderEmail
    properties['notificationSenderEmail'] || nil
  end

  def scmUrl
    properties['scmUrl'] || nil
  end


  def to_s
    "Azure API Management Service : #{name}"
  end


end
