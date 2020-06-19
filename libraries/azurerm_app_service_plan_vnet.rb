# frozen_string_literal: true

require 'azurerm_resource'

class AzurermAppServicePlanVnet < AzurermSingularResource
  name 'azurerm_app_service_plan_vnet'
  desc 'Verifies settings for an Azure App Service Plan Vnet'
  example <<-EXAMPLE
    describe azurerm_app_service_plan_vnet(resource_group: 'rg-1',  plan_name: 'myplanname', vnet_name: 'myvnet') do
      it { should exist }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    type
    properties
    kind
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, plan_name: nil, vnet_name: )
    records = management.azurerm_app_service_plan_vnet(resource_group: resource_group, plan_name: plan_name, vnet_name: vnet_name )
    return if has_error?(records)
    assign_fields(ATTRS, records)
    @exists = true
  end


  def certBlob
    properties('certBlob') || nil
  end

  def certThumbprint
    properties('certThumbprint') || nil
  end

  def dnsServers
    val = properties('dnsServers') || ''
    val.split(',')  
  end

  def route_names
    @route_names = routes.collect{ |r| r.name }
  end

  def routes
    @routes =  properties('routes') || [] 
  end

  def swift?
    properties('isSwift') || false
  end  

  def resync_required?
    properties('resyncRequired') || false
  end  

  def vnet_resource_id
    properties('vnetResourceId') || nil
  end  

  def to_s
    "Azure App Service Plan Vnet: '#{name}'"
  end

end
