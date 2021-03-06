--[[
Copyright 2014 Rackspace

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]

local constants = require('./constants')
local staging = require('./staging')
local endpoint = require('virgo/client/endpoint')

local function getEndpointSRV()
  if staging.isStaging() then
    return constants:get('DEFAULT_MONITORING_SRV_QUERIES_STAGING')
  end
  return constants:get('DEFAULT_MONITORING_SRV_QUERIES')
end

local function getServiceNetSRV()
  if staging.isStaging() then
    return constants:get('SNET_MONITORING_TEMPLATE_SRV_QUERIES_STAGING')
  end
  return constants:get('SNET_MONITORING_TEMPLATE_SRV_QUERIES')
end

exports.Endpoint = endpoint.Endpoint
exports.getEndpointSRV = getEndpointSRV
exports.getServiceNetSRV = getServiceNetSRV
