view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_user_id {
    type: string
    sql: concat(${id},'-',${user_id}) ;;
  }

  measure: first_order_lag {
    type: number
    sql: datediff(min(${created_date}),${users.created_at_date}) ;;
  }

  set: detail {
    fields: [
      id,
      users.first_name,
      users.last_name,
      users.id,
      hello_world.count,
      order_items.count
    ]
    }




filter: period_length {
  type: date
  default_value: "90 days"
}

dimension: num_days {
  # hidden: yes
  type: string
  sql: datediff({% date_end period_length %},{% date_start period_length %}) ;;
}

dimension: period_comparison {
  # hidden: yes
  allow_fill: no
  type: string
  case: {
    when: {sql: datediff(now(),${created_date}) < ${num_days};; label: "Current period"}
    when: {sql: datediff(now(),${created_date}) < (${num_days} + ${num_days}) ;; label: "Prior period"}
    else: "Out of date period range"
  }
}

}
