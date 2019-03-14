connection: "thelook"
# include all views in this project
# include: "*.view"

# include all dashboards in this project
# include: "*.dashboard"

view: order_product {
  derived_table: {
    persist_for: "24 hours"
    indexes: ["order_id", "created_at"]
    sql: SELECT o.id as order_id
      , oi.id as order_item_id
      , o.created_at
      , oi.inventory_item_id as inventory_item_id
      , p.item_name as product
      FROM order_items oi
      JOIN orders o ON o.id = oi.order_id
      JOIN inventory_items ii ON oi.inventory_item_id = ii.id
      JOIN products p ON ii.product_id = p.id
      GROUP BY order_id, item_name, created_at
       ;;
  }
}

view: total_order_product {
  derived_table: {
    sql: SELECT p.item_name as product
      , count(distinct p.item_name, o.id) as product_order_count    -- count of orders with product, not total order items
      FROM order_items oi
      JOIN orders o ON o.id = oi.order_id
      JOIN inventory_items ii ON oi.inventory_item_id = ii.id
      JOIN products p ON ii.product_id = p.id
      WHERE {% condition order_purchase_affinity.affinity_timeframe %} o.created_at {% endcondition %}
      GROUP BY p.item_name
       ;;
  }
}

view: total_orders {
  derived_table: {
    sql: SELECT count(*) as count
      FROM orders
      WHERE {% condition order_purchase_affinity.affinity_timeframe %} created_at {% endcondition %}
       ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
    view_label: "Order Purchase Affinity"
    label: "Total Order Count"
  }
}

explore: order_purchase_affinity {
  label: "Affinity"
  view_label: "Affinity"

  always_filter: {
    filters: {
      field: affinity_timeframe
      value: "last 90 days"
    }
  }

  join: total_orders {
    type: cross
    relationship: many_to_one
  }
}

view: order_purchase_affinity {
  derived_table: {
    #    persist_for: 24 hours
    indexes: ["product_a"]
    sql: SELECT product_a
      , product_b
      , joint_order_count
      , top1.product_order_count as product_a_order_count   -- total number of orders with product A in them
      , top2.product_order_count as product_b_order_count   -- total number of orders with product B in them
      FROM (
        SELECT op1.product as product_a
        , op2.product as product_b
        , count(*) as joint_order_count
        FROM ${order_product.SQL_TABLE_NAME} as op1
        JOIN ${order_product.SQL_TABLE_NAME} op2
        ON op1.order_id = op2.order_id
        AND op1.order_item_id <> op2.order_item_id            -- ensures we don't match on the same order items in the same order, which would corrupt our frequency metrics
        WHERE {% condition affinity_timeframe %} op1.created_at {% endcondition %}
        AND {% condition affinity_timeframe %} op2.created_at {% endcondition %}
        GROUP BY product_a, product_b
      ) as prop
      JOIN ${total_order_product.SQL_TABLE_NAME} as top1 ON prop.product_a = top1.product
      JOIN ${total_order_product.SQL_TABLE_NAME} as top2 ON prop.product_b = top2.product
      ORDER BY product_a, joint_order_count DESC, product_b
       ;;
  }

  filter: affinity_timeframe {
    type: date
  }

  dimension: product_a {
    type: string
    sql: ${TABLE}.product_a ;;
  }

  dimension: product_b {
    type: string
    sql: ${TABLE}.product_b ;;
  }

  dimension: joint_order_count {
    description: "How many times item A and B were purchased in the same order"
    type: number
    sql: ${TABLE}.joint_order_count ;;
    value_format: "#"
  }

  dimension: product_a_order_count {
    description: "Total number of orders with product A in them, during specified timeframe"
    type: number
    sql: ${TABLE}.product_a_order_count ;;
    value_format: "#"
  }

  dimension: product_b_order_count {
    description: "Total number of orders with product B in them, during specified timeframe"
    type: number
    sql: ${TABLE}.product_b_order_count ;;
    value_format: "#"
  }

  #  Frequencies
  dimension: product_a_order_frequency {
    description: "How frequently orders include product A as a percent of total orders"
    type: number
    sql: 1.0*${product_a_order_count}/${total_orders.count} ;;
    value_format: "#.00%"
  }

  dimension: product_b_order_frequency {
    description: "How frequently orders include product B as a percent of total orders"
    type: number
    sql: 1.0*${product_b_order_count}/${total_orders.count} ;;
  }

  #     value_format: '#.00%'

  dimension: joint_order_frequency {
    description: "How frequently orders include both product A and B as a percent of total orders"
    type: number
    sql: 1.0*${joint_order_count}/${total_orders.count} ;;
    value_format: "#.00%"
  }

  # Affinity Metrics

  dimension: add_on_frequency {
    description: "How many times both Products are purchased when Product A is purchased"
    type: number
    sql: 1.0*${joint_order_count}/${product_a_order_count} ;;
    value_format: "#.00%"
  }

  dimension: lift {
    description: "The likelihood that buying product A drove the purchase of product B"
    type: number
    sql: 1*${joint_order_frequency}/(${product_a_order_frequency} * ${product_b_order_frequency}) ;;
  }

  ## Do not display unless users have a solid understanding of  statistics and probability models
  dimension: jaccard_similarity {
    description: "The probability both items would be purchased together, should be considered in relation to total order count, the highest score being 1"
    type: number
    sql: 1.0*${joint_order_count}/(${product_a_order_count} + ${product_b_order_count} - ${joint_order_count}) ;;
    value_format: "#,##0.#0"
  }

  # Aggregate Measures - ONLY TO BE USED WHEN FILTERING ON AN AGGREGATE DIMENSION (E.G. BRAND_A, CATEGORY_A)


  measure: aggregated_joint_order_count {
    description: "Only use when filtering on a rollup of product items, such as brand_a or category_a"
    type: sum
    sql: ${joint_order_count} ;;
  }
}
