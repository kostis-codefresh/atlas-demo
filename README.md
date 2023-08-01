# atlas-template

A template repo for using Atlas.

## Getting started

## Quick installation

**macOS + Linux:**

```bash
curl -sSf https://atlasgo.sh | sh
```

**Homebrew:**

```bash
brew install ariga/tap/atlas
```

**Docker:**

```bash
docker pull arigaio/atlas
```

Click [here](https://atlasgo.io/getting-started#installation) to read instructions for other platforms.

## Creating a container image

This repo comes with a bootstrapped Dockerfile to package the migrations as a container image.

Build the container image:

```console
docker build -t atlas:local .
```

## Common actions

This repo comes with preconfigured `atlas.hcl` that defines a local MySQL-based dev environment named "local" which
you can reference using the `--env local` flag.

### Plan a new migration

Modify the desired schema of your database `schema.hcl`:

```diff
schema "app" {

}

table "users" {
  schema = schema.app
  column "id" {
    type = int
  }
  column "user_name" {
    type = varchar(255)
    unique = true
  }
  column "email" {
    type = varchar(255)
    unique = true
  }
+  column "bio" {
+    type = text
+    unique = true
+  }
  primary_key {
    columns = [column.id]
  }
}
```

Automatically generate a migration file:

```bash
atlas migrate diff --env local
```

_To learn more about defining database schemas in HCL, check out the [SQL resource](https://atlasgo.io/atlas-schema/sql-resources)
documentation._

### Apply a migration

Apply the migration directory to your database:

```bash
atlas migrate apply --env local -u "mysql://root:pass@database-url:3306/app"
```

### Lint the migration directory

Verify the latest migration file in the directory is safe to apply:

```bash
atlas migrate lint --env local --latest 1
```
