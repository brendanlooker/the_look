view: order_items {
  sql_table_name: demo_db.order_items ;;

  measure: count_order_items {
    description: "Count of Order Items"
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sales_price_tier {
    type: tier
    tiers: [0, 25, 50, 100, 500, 1000]
    style: integer
    sql: ${sale_price} ;;
  }
  measure: max_sale_price {
    type: max
    sql: ${sale_price};;
  }
  measure: min_sale_price {
    type: min
    sql: ${sale_price};;
  }
  measure: sale_price_average {
    type: average
    sql: ${sale_price};;
  }
  dimension: revenue {
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
    value_format_name: "usd"
  }

  measure: average_revenue{
    type: average
    sql:${revenue} ;;
    value_format_name: "usd"
    drill_fields: [orders.id,order_items.sale_price,revenue]
  }


  measure: is_greater_than_average_sale_price{
    type: yesno
    sql: ${sale_price} >= ${sale_price_average} ;;
  }

  set: detail {
    fields: [id, order_id, sale_price, inventory_item_id, returned_at_time]
  }
}
