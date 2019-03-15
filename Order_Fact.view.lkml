view: order_fact {
  derived_table: {
    sql: select oi.id as order_items_id,
      oi.order_id,
      oi.sale_price,
      oi.inventory_item_id,
      oi.returned_at,
      o.created_at as order_created_at,
      o.user_id as order_user_id,
      o.status as order_status,
      u.email,
      u.first_name,
      u.last_name,
      u.gender,
      u.created_at as user_created_at,
      u.zip,
      u.country,
      u.state,
      u.city,
      u.age,
      ii.product_id,
      ii.created_at as inventory_item_created_at,
      ii.sold_at as sold_at,
      ii.cost,
      p.category as product_category,
      p.item_name as product_item_name,
      p.brand,
      p.retail_price,
      p.department as product_department,
      p.rank as product_rank,
      p.sku
from order_items oi
left outer join orders o on oi.order_id = o.id
left outer join users u on o.user_id = u.id
left outer join inventory_items ii on oi.inventory_item_id = ii.id
left outer join products p on ii.product_id = p.id
 ;;
datagroup_trigger: order_fact_datagroup
indexes: ["order_items_id"]
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_items_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: order_created_at {
    type: time
    sql: ${TABLE}.order_created_at ;;
  }

  dimension: order_user_id {
    type: number
    sql: ${TABLE}.order_user_id ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.order_status ;;
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

  dimension_group: user_created_at {
    type: time
    sql: ${TABLE}.user_created_at ;;
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

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: inventory_item_created_at {
    type: time
    sql: ${TABLE}.inventory_item_created_at ;;
  }

  dimension_group: sold_at {
    type: time
    sql: ${TABLE}.sold_at ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
    view_label: "Product"
  }

  dimension: product_item_name {
    type: string
    sql: ${TABLE}.product_item_name ;;
    view_label: "Product"
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    view_label: "Product"
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
    view_label: "Product"
  }

  dimension: product_rank {
    type: number
    sql: ${TABLE}.product_rank ;;
    view_label: "Product"
  }

  dimension: sku {
    type: string
    hidden: yes
    sql: ${TABLE}.sku ;;
  }

  dimension: orders_pending {
    type: string
    sql: case when ${order_status} = "Pending" ;;
    view_label: "Order Status"
  }

  dimension: orders_complete {
    type: string
    sql: case when ${order_status} = "Complete" ;;
    view_label: "Order Status"
  }

  dimension: orders_cancelled {
    type: string
    sql: case when ${order_status} = "Cancelled" ;;
    view_label: "Order Status"
  }

  dimension: item_value {
    type: tier
    sql: ${sale_price} ;;
    tiers: [10,100,1000]
  }

  measure: Sum_Sales {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: in_stock_number_of_days {
    type: number
    sql: datediff(${sold_at_date},${inventory_item_created_at_date});;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  set: detail {
    fields: [
      order_items_id,
      order_id,
      sale_price,
      inventory_item_id,
      returned_at_time,
      order_created_at_time,
      order_user_id,
      order_status,
      email,
      first_name,
      last_name,
      gender,
      user_created_at_time,
      zip,
      country,
      state,
      city,
      age,
      product_id,
      inventory_item_created_at_time,
      sold_at_time,
      cost,
      product_category,
      product_item_name,
      brand,
      retail_price,
      product_department,
      product_rank,
      sku
    ]
  }
}
