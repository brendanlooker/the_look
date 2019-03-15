view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

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

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension_group: created_at {
      type: time
      sql: ${TABLE}.created_at ;;
      drill_fields: [detail*]
    }

    dimension_group: sold_at {
      type: time
      sql: ${TABLE}.sold_at ;;
    }

    dimension: cost {
      type: number
      sql: ${TABLE}.cost ;;
      value_format_name: usd
    }

    set: detail {
      fields: [id, product_id, created_at_time, sold_at_time, cost]
    }
  }
