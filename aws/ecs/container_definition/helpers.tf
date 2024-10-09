module "data" {
  source = "../../../data"
}

module "artifact_image_validator" {
  source = "../../error_handler"

  artifact_url = local.image
}
