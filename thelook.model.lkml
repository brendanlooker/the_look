connection: "thelook"

include: "*.view.lkml"                       # include all views in this project



access_grant: can_view_orders_explore {
  allowed_values: ["USA"]
  user_attribute: country
}

explore: order_items {

#   sql_always_where: {% if _user_attributes['country'] == 'USA' %} ${products.brand} = "{{ _user_attributes['brand'] }}"
#   {% else %} 1 = 1 {% endif %};;

  access_filter: {
    field: users.country
    user_attribute: country
  }


#   required_access_grants: [can_view_orders_explore]

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id}=${orders.id} ;;
    relationship: many_to_one
  }
  join: users {
    type: left_outer
    sql_on: ${orders.user_id}=${users.id} ;;
    relationship: many_to_one
    view_label: "Users"
    }
  join: user_first_order {
    type: inner
    sql_on: ${users.id}=${user_first_order.id} ;;
    relationship: one_to_one
    view_label: "Users Orders"
  }
  join: inventory_items {
    type:left_outer
    sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
    relationship: one_to_one
    }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.id}=${products.id} ;;
    relationship: many_to_one
    fields: [products.id,products.item_name,products.brand, products.category, products.department, products.product_count]
    view_label: "Products"
    }
  group_label: "E Commerce"
  label: "Orders All"

}


##########################


explore: user_first_order {}

# explore: orders {
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id}=${users.id} ;;
#     relationship: many_to_one
#   }
#   fields: [ALL_FIELDS*,-users.email,-users.first_name]
# }
#
# explore: users {
#   persist_with: users_datagroup
#   always_filter: {
#     filters: {
#       field: last_name
#       value: "Sims"
#       }
#     }
#   sql_always_where: ${state}<>'Indiana' ;;
#
#   }
#
# datagroup: users_datagroup {
#   sql_trigger: select count(*) from dem0_db.users ;;
#   max_cache_age: "24 hours"
# }

##########################

# explore: bla {
#   from: order_items
#   join: orders {
#     type: left_outer
#     relationship: many_to_one
#     sql_on:${bla.order_id}=${orders.id} ;;
#     }
#   join: orders2 {
#     from: orders
#     type: inner
#     relationship: one_to_one
#     sql_on: ${bla.order_id}=${orders2.id};;
#   }
# }


# explore: orders {}
#
# explore: order_fact {
#   group_label: "E Commerce"
#   label: "Orders Fact"
# }
#
# datagroup: order_fact_datagroup {
#   max_cache_age: "4 hours"
#   sql_trigger: SELECT date(now()) FROM ${TABLE}  ;;
# }
