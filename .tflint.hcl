# https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/README.md
# https://github.com/terraform-linters/tflint-ruleset-terraform/tree/main/docs/rules

config {
  call_module_type = "local"
  disabled_by_default = false

  # Doesn't work from here in --resursive mode
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"
}

plugin "aws" {
  enabled = true
  version = "0.33.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_deprecated_lookup" {
  enabled = false
}

rule "terraform_documented_outputs" {
  enabled = false
}

rule "terraform_naming_convention" {
  enabled = false
}

rule "terraform_standard_module_structure" {
  enabled = false
}

rule "terraform_typed_variables" {
  enabled = false
}
