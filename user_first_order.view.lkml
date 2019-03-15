view: user_first_order {
  derived_table: {
    sql: select u.id,
                min((DATE(orders.created_at ))) as first_order_date,
                max((DATE(orders.created_at ))) as last_order_date,
                datediff(min((DATE(orders.created_at ))),DATE(u.created_at)) as first_order_lag,
                datediff(now(),max((DATE(orders.created_at )))) as last_order_lag
      from orders left outer
      join users u on orders.user_id = u.id
      group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: first_order_date {
    hidden: yes
    type: date
    sql: ${TABLE}.first_order_date ;;
  }

  dimension: last_order_date {
    hidden: yes
    type: date
    sql: ${TABLE}.last_order_date ;;
    description: "Difference (in days) between when the last order was received and now"
  }

  dimension: first_order_lag {
    hidden: yes
    type: number
    sql: ${TABLE}.first_order_lag ;;
  }

  dimension: last_order_lag {
    hidden: yes
    type: number
    sql: ${TABLE}.last_order_lag ;;
  }

  measure: average_first_order_lag {
    type: average
    sql: ${first_order_lag} ;;
    value_format: "0"
    drill_fields: [detail*]
  }

  measure: average_last_order_lag {
    type: average
    sql: ${last_order_lag} ;;
    value_format: "0"
    drill_fields: [detail*]
  }

  set: detail {
    fields: [id, first_order_date,last_order_date, first_order_lag,last_order_lag]
  }
}
