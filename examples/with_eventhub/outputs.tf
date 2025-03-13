// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "api_management_name" {
  description = "The name of the API Management Service"
  value       = module.apim.api_management_name
}

output "api_management_id" {
  description = "The ID of the API Management Service"
  value       = module.apim.api_management_id
}

output "api_management_gateway_url" {
  description = "The URL of the Gateway for the API Management Service"
  value       = module.apim.api_management_gateway_url
}

output "resource_group_name" {
  value = module.resource_group.name
}

# output "logger_id" {
#   value = module.apim_logger.logger_id
# }

# output "logger_name" {
#   value = module.apim_logger.logger_name
# }

# output "logger_resource_id" {
#   value = module.apim_logger.logger_resource_id
# }
