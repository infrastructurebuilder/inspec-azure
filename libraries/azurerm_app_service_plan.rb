# frozen_string_literal: true

require 'azurerm_resource'

class AzurermAppServicePlan < AzurermSingularResource
  name 'azurerm_app_service_plan'
  desc 'Verifies settings for an Azure App Service Plan'
  example <<-EXAMPLE
    describe azurerm_app_service_plan(resource_group: 'rg-1',  plan_name: 'myplanname') do
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
    sku
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, plan_name: )
    @name = name
    @resource_group = resource_group
    @plan_name = plan_name
    record = management.app_service_plan(resource_group: resource_group, plan_name: plan_name )
    return if has_error?(record)
    @exists = true
  end

  def status
    properties('status') || nil
  end
  def maximumNumberOfWorkers
    properties('maximumNumberOfWorkers') || nil
  end
  def geoRegion
    properties('geoRegion') || nil
  end
  def numberOfSites
    properties('numberOfSites') || nil
  end
  def isSpot
    properties('isSpot') || nil
  end
  def reserved
    properties('reserved') || nil
  end
  def targetWorkerCount
    properties('targetWorkerCount') || nil
  end
  def targetWorkerSizeId
    properties('targetWorkerSizeId') || nil
  end
  def provisioningState
    properties('provisioningState') || nil
  end

  def to_s
    "Azure App Service Plan: #{name}"
  end
end
