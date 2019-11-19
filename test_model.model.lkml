connection: "thelook"

include: "*.view.lkml"                       # include all views in this project


explore: order_items {
  view_name: order_items
  fields: [ALL_FIELDS*,-order_items.revenue]
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one

  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


explore: inventory_items {
  view_name: inventory_items
  join: products {
    type: left_outer
    sql_on: ${inventory_items.id}=${products.id} ;;
    relationship: many_to_one
    fields: [products.id,products.item_name,products.brand, products.category, products.department, products.product_count]
    view_label: "Products"
  }

}

#####################################

# Extended Explore Example

explore: my_extended_explore{
  extends: [order_items,inventory_items]
  join: order_items {
    # from: order_items
    sql_on: ${inventory_items.id}=${order_items.inventory_item_id} ;;
    relationship: one_to_one
  }
}

#####################################
