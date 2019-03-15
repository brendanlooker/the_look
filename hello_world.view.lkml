view: hello_world {
  sql_table_name: demo_db.HELLO_WORLD ;;

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  measure: count {
    type: count
    drill_fields: [orders.id]
  }
}
