variable "cloud_token" { 
  type    = string
  default = getenv("ATLAS_TOKEN")
}
  
atlas {
  cloud {
    token = var.cloud_token
  }
}

data "remote_dir" "migration" {
  name = "demo"
}

env {
  name = atlas.env
  url  = getenv("DATABASE_URL")
  migration {
    dir = data.remote_dir.migration.url
  }
}