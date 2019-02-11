view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: product_id {
      type: number
      sql: ${TABLE}.product_id ;;
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

    measure: total_cost_by_gender_female {
      type: count
      filters: {
        field:users.gender
        value: "f"
      }
    }

  measure: total_cost_by_gender_male {
    type: count
    filters: {
      field:users.gender
      value: "m"
    }
  }

    set: detail {
      fields: [id, product_id, created_at_time, sold_at_time, cost]
    }
  }
