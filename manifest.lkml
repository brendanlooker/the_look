project_name: "the_look"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "sso_demo"
# }

remote_dependency: sso_demo_dependency  {
  url: "git://github.com/brendanlooker/sso_v2.git"
  ref: "a1a2d03191d0c2cf3cd33a10d648b34a46e83efa"
}
