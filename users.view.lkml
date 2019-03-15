view: users {
  sql_table_name: demo_db.users ;;

    measure: user_count {
      type: count
      drill_fields: [detail*]
      value_format: "0"

    }

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: email {
      type: string
      sql: ${TABLE}.email ;;
    }

    dimension: first_name {
      type: string
      sql: ${TABLE}.first_name ;;
    }

    dimension: last_name {
      type: string
      sql: ${TABLE}.last_name ;;
    }

    dimension: gender {
      type: string
      sql: ${TABLE}.gender ;;
    }

    dimension_group: created_at {
      type: time
      sql: ${TABLE}.created_at ;;
    }

    dimension: zip {
      type: zipcode
      sql: ${TABLE}.zip ;;
    }

    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    dimension: state {
      type: string
      sql: ${TABLE}.state ;;
    }

    dimension: city {
      type: string
      sql: ${TABLE}.city ;;
    }

    dimension: age {
      type: number
      sql: ${TABLE}.age ;;
    }


  dimension: age_tier {
    type: tier
    tiers: [19,26,41,51,76,100]
    sql: ${age} ;;
    style: integer
  }

  measure: total_orders {
    type: number
    sql: count(${order_items.id}) ;;
  }



#   measure: average_number_of_orders{
#     type: average
#     sql:count(${order_items.id}) ;;
#     value_format: "0"
#   }

#   dimension: first_order_date {
#     type: date
#     sql: min(${orders.created_date}) ;;
#   }
#
#   dimension: order_lag {
#     type: number
#     sql: datediff(${first_order_date},${created_at_date});;
#   }

#   measure: average_order_lag {
#     type: number
#     sql: avg(${order_lag});;
#   }

    set: detail {
      fields: [
        id,
        email,
        first_name,
        last_name,
        gender,
        created_at_time,
        zip,
        country,
        state,
        city,
        age
      ]
    }
  }
