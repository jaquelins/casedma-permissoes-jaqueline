resource "aws_lakeformation_permissions" "database_permission_sor" {
    principal   = var.producer_role_arn_mesh
    permissions = ["DESCRIBE", "CREATE_TABLE", "ALTER", "DROP"]

    database {
      name       = var.database_sor
      catalog_id = var.control_account
    }
}

resource "aws_lakeformation_permissions" "database_permision_sot" {
    principal   = var.producer_role_arn_mesh
    permissions = ["DESCRIBE", "CREATE_TABLE", "ALTER", "DROP"]

    database {
        name       = var.database_sot
        catalog_id = var.control_account
    }
}

resource "aws_lakeformation_permissions" "database_permission_spec" {
    principal   = var.producer_role_arn_mesh
    permissions = ["DESCRIBE", "CREATE_TABLE", "ALTER", "DROP"]

    database {
        name       = var.database_spec
        catalog_id = var.control_account
    }
}
