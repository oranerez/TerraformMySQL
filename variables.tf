# Password List

variable "databases" {
  type        = list(string)
  default     = ["TestDB1", "TestDB2", "TestDB3"]  
  description = "List of Databases"
}

# Users and passwords mapping

variable "users_passwords" {
  type = map
  default = {
    "User1"     = "wEi7aBRJ"
    "User2"     = "6L29w7VY"
    "User3"     = "Mz7J4R1C"
    "User4"     = "gYMo5iH6"
  # description = "Mapping list of users and associated passwords"
  }
}

variable "user_db_privilege_association" {
  default = {
    "User1" = {
      "password" : ["wEi7aBRJ"],
      "databases" : ["TestDB1", "TestDB2", "TestDB3"]
    # },
    }
    # "User2" = {
    #   "password" : "6L29w7VY",
    #   "database" : ["TestDB1", "TestDB2", "TestDB3"],
    # },
    # "User3" = {
    #   "password" : "Mz7J4R1C",
    #   "database" : ["TestDB1", "TestDB2", "TestDB3"]
    # },
    # "User4" = {
    #   "password" : "gYMo5iH6",
    #   "database" : ["TestDB1", "TestDB2", "TestDB3"]
    # }        
  }
}

locals {
  flat_list = flatten([
    for user, value in (var.user_db_privilege_association) : [
      for password in value : [
        for database in password : [
           {
            user     = user
            password = password
            database = database
          }
        ]
      ]
    ]
  ])  
}


# variable "dbconfig_preveligies" {
#   type = map(list(string))
#   default = {
#     TestDB1 = [
#       "SELECT"
#     ],
#     TestDB2 = [
#       "SELECT"
#     ],
#     TestDB3 = [
#       "SELECT"
#     ]
#   }
# }

# variable "null_var" {
#   type = string
#   default = null
# }



##### Backup ######

# locals {
#   flat_list = flatten([
#     for user in keys(var.user_db_privilege_association) : [
#       for password in values(var.user_db_privilege_association) : [
#         for database in password : [
#            {
#             user     = user
#             password = password
#             database = database
#           }
#         ]
#       ]
#     ]
#   ])  
# }
