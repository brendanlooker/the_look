connection: "thelook"
include: "*.view.lkml"                       # include all views in this project



access_grant: can_view_orders_explore {
  allowed_values: ["USA"]
  user_attribute: country
}

explore: users_aroo{
  from: users
  sql_always_where: {% if _user_attributes['city'] ==  %} 1=0 {% else %} ${city} = ({{ _user_attributes['city'] }}) {% endif %};;

}
explore: products_extended {}

explore: order_items {

#   sql_always_where: {% if _user_attributes['country'] == 'USA' %} ${products.brand} = "{{ _user_attributes['brand'] }}"
#   {% else %} 1 = 1 {% endif %};;

  # access_filter: {
  #   field: users.country
  #   user_attribute: country
  # }

  # sql_always_where: {% condition _user_attributes['country'] %} ${users.country} {% endcondition %};;
  sql_always_where: ${users.country} in ({{ _user_attributes['country'] }});;


  # required_access_grants: [can_view_orders_explore]

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

explore: products {}


##########################


explore: user_first_order {}
