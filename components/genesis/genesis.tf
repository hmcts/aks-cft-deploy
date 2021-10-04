module "genesis" {
  source           = "git::https://github.com/hmcts/aks-module-genesis.git?ref=cftsds"
  environment      = local.environment
  tags             = module.ctags.common_tags
  developers_group = local.developers_group
  project          = var.project
}
module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}