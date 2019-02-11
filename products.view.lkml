view: products {
  sql_table_name: demo_db.products ;;

    measure: product_count {
      type: count
      drill_fields: [detail*]
    }

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: category {
      type: string
      sql: ${TABLE}.category ;;
    }

    dimension: item_name {
      type: string
      sql: ${TABLE}.item_name ;;
    }

    dimension: brand {
      type: string
      sql: ${TABLE}.brand ;;
    }

    dimension: retail_price {
      type: number
      sql: ${TABLE}.retail_price ;;
    }

    dimension: department {
      type: string
      sql: ${TABLE}.department ;;
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
    }

    dimension: sku {
      type: string
      sql: ${TABLE}.sku ;;
    }

  dimension: category_brand {
    type: string
    sql: concat(${brand}, " ",${category}) ;;
  }


    set: detail {
      fields: [
        id,
        category,
        item_name,
        brand,
        retail_price,
        department,
        rank,
        sku
      ]
    }
  }
