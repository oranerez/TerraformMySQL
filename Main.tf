terraform {
  required_version = ">= 0.12.6"
}

provider "mysql" {
  endpoint = "127.0.0.1:3306"
  username = "root"
  password = "Test123"
}

# Create a Database
resource "mysql_database" "app" {
  for_each = toset(var.databases)
  # for_each = var.user_db_privilege_association
  name     = each.value
}

# Create a user and password
resource "mysql_user" "user" {
  for_each           = var.users_passwords
  user               = each.key
  host               = "%"
  plaintext_password = each.value
}


# output "test" {
#   value = local.flat_list
# }

# output "test" {
#   value = ["${var.user_db_privilege_association}"]
# }


# Grant Select privilege to User on DB
resource "mysql_grant" "user" {
  depends_on = [mysql_database.app, mysql_user.user]
  # for_each = local.flat_list
  # for_each = { for output in local.flat_list : output.user => output... }
  for_each = var.users_passwords
  user     = each.key
  host     = "%"
  database   = "TestDB1"
  # database   = each.value.database
  privileges = ["SELECT"]
}






### Backup ####

# # Grant Select privilege to User on DB
# resource "mysql_grant" "user" {
#   depends_on = [mysql_database.app, mysql_user.user]
#   # for_each = local.previlige_user_db_map
#   for_each = var.users_passwords
#   user     = each.key
# #   # user     = [for key in each.key: key] 
# #   # "${if each.key == abs(each.key) ? each.key : var.null_var}"]
#   host     = mysql_user.user.host
# #   # database   = "${[ for dbname in mysql_database.app.name: dbname ]}"
#   privileges = ["SELECT"]
# #   #   count      = "${length(var.databases)}"
# #   #   database   = "${element(var.databases, count.index)}"
# }