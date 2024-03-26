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
resource "aws_glue_catalog_table" "tabela_sor" {
  depends_on = ["aws_lakeformation_permissions.database_permission_sor"]
  name            = var.tabela_sor
  database_name   = var.database_sor
  table_type      = "EXTERNAL_TABLE"
 
  parameters = {
    classification = "parquet"
  }
  partition_keys {
    name           = "anomes"
    type           = "int"
  }
  storage_descriptor {
    location       = "${var.sor_s3_bucket}/${var.tabela_sor}"
    input_format   = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    ser_de_info {
      name = var.tabela_sor
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }
 
    columns {
        name           = "id"
        type           = "int"
    }
 
    columns {
        name           = "trans_date_trans_time"
        type           = "timestamp"
    }
 
    columns {
        name           = "cc_num"
        type           = "string"
    }
 
    columns {
        name           = "merchant"
        type           = "string"
    }
 
    columns {
        name           = "category"
        type           = "string"
    }
 
    columns {
        name           = "amt"
        type           = "decimal(18, 2)"
    }
 
    columns {
        name           = "first"
        type           = "string"
    }
 
    columns {
        name           = "last"
        type           = "string"
    }
 
    columns {
        name           = "gender"
        type           = "string"
    }
 
    columns {
        name           = "street"
        type           = "string"
    }
 
    columns {
        name           = "city"
        type           = "string"
    }
 
    columns {
        name           = "state"
        type           = "string"
    }
 
    columns {
        name           = "zip"
        type           = "string"
    }
 
    columns {
        name           = "lat"
        type           = "decimal(18, 3)"
    }
 
    columns {
        name           = "long"
        type           = "decimal(18, 3)"
    }
 
    columns {
        name           = "city_pop"
        type           = "bigint"
    }
 
    columns {
        name           = "job"
        type           = "string"
    }
 
    columns {
        name           = "dob"
        type           = "date"
    }
 
    columns {
        name           = "trans_num"
        type           = "string"
    }
 
    columns {
        name           = "unix_time"
        type           = "string"
    }
 
    columns {
        name           = "merch_lat"
        type           = "decimal(18, 3)"
    }
 
    columns {
        name           = "merch_long"
        type           = "decimal(18, 3)"
    }
 
    columns {
        name           = "is_fraud"
        type           = "int"
    }
 
    columns {
        name           = "dt_carga"
        type           = "timestamp"
    }
  }
}