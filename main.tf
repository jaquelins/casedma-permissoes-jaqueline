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

###Criação da tabela SOT###

resource "aws_glue_catalog_table" "tabela_sot" {
  name            = var.tabela_sot
  database_name   = var.database_sot
  table_type      = "EXTERNAL_TABLE"

  parameters = {
    classification = "parquet"
  }
  partition_keys {
    name           = "anomes"
    type           = "int"
  }
  storage_descriptor {
    location       = "${var.sot_s3_bucket}/${var.tabela_sot}"
    input_format   = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    ser_de_info {
      name = var.tabela_sot
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }
        columns {
        name = "id"
        type = "int"
    }

    columns {
        name = "trans_date_trans_time"
        type = "timestamp"
    }

    columns {
        name = "cc_num"
        type = "string"
    }

    columns {
        name = "category"
        type = "string"
    }

    columns {
        name = "amt"
        type = "decimal(18,2)"
    }

    columns {
        name = "first_name"
        type = "string"
    }

    columns {
        name = "last_name"
        type = "string"
    }

    columns {
        name = "gender"
        type = "string"
    }

    columns {
        name = "dob"
        type = "date"
    }

    columns {
        name = "dt_carga"
        type = "timestamp"
    }
  }
}

resource "aws_lakeformation_permissions" "table_permissions_sot_producer" {

  principal = var.producer_role_arn_mesh
  permissions = ["SELECT", "INSERT", "ALTER", "DROP"]
  table {
    database_name = var.database_sot
    name = var.tabela_sot
  }
}


##Criação da tabela SPEC##

resource "aws_glue_catalog_table" "tabela_spec" {
  name            = var.tabela_spec
  database_name   = var.database_spec
  table_type      = "EXTERNAL_TABLE"

  parameters = {
    classification = "parquet"
  }
  partition_keys {
    name           = "ano_mes_transacoes"
    type           = "int"
  }
  storage_descriptor {
    location       = "${var.spec_s3_bucket}/${var.tabela_spec}"
    input_format   = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    ser_de_info {
      name = var.tabela_spec
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }

    columns {
      name = "numero_cartao_credito_cliente"
      type = "string"
      comment = "cc_num"
    }

    columns {
      name = "nome_cliente"
      type = "string"
      comment = "first_name"
    }

    columns {
      name = "sobrenome_cliente"
      type = "string"
      comment = "last_name"
    }

    columns {
      name = "genero_pessoa"
      type = "string"
      comment = "gender"
    }

    columns {
      name = "idade_cliente"
      type = "int"
      comment = "idade_cliente"
    }

    columns {
      name = "soma_valor_transacoes"
      type = "decimal(18, 2)"
      comment = "soma_valor_transacoes"
    }

    columns {
      name = "qtd_transacoes"
      type = "int"
      comment = "qtd_transacoes"
    }

    columns {
      name = "dt_carga"
      type = "timestamp"
      comment = "dt_carga"
    }
  }
}
resource "aws_lakeformation_permissions" "table_permissions_spec_producer" {

  principal = var.producer_role_arn_mesh
  permissions = ["SELECT", "INSERT", "ALTER", "DROP"]
  table {
    database_name = var.database_spec
    name = var.tabela_spec
  }
}
