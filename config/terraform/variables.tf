variable "service_id" {
  type        = string
  default     = "polvo-endpoint"
  description = "The id of the service. Should be a single word"
}

variable "service_base_domain" {
  type        = string
  default     = "aiocean.services"
  description = "Base do main for the service. It should be already exists"
}

variable "project_id" {
  type        = string
  default     = "aio-shopify-services"
  description = "The project name"
}

variable "env" {
  type        = string
  default     = "develop"
  description = "The environment"
}

variable "region" {
  type        = string
  default     = "asia-southeast1"
  description = "The region"
}

variable "esp_version" {
  type        = string
  default     = "2.27.0"
  description = "ESP Version"
}

variable "endpoint_config_id" {
  type        = string
  default     = "2021-06-09r2"
  description = "API Config ID. Example: 2021-05-14r3"
}

locals {
  endpoint_service_id = "${var.service_id}.endpoints.${var.project_id}.cloud.goog"
  service_domain    = "${var.service_id}.${var.service_base_domain}"
  service_full_name = "${var.service_id}-service"
  docker_image_url = "gcr.io/${var.project_id}/endpoints-runtime-serverless:${var.esp_version}-${local.endpoint_service_id}-${var.endpoint_config_id}"
}
