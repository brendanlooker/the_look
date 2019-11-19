view: products {
  sql_table_name: demo_db.products ;;
  # extension: required


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

    dimension: count_something {
      type: number
      sql: select count(${id}) from  demo_db.products;;
    }

    dimension: item_name {
      type: string
      sql: ${TABLE}.item_name ;;
    }

    dimension: brand {
      type: string
      sql: ${TABLE}.brand ;;
      link: {
        label: "Google {{ value }}"
        url: "http://www.google.com/search?q={{ value }}"
        icon_url: "http://google.com/favicon.ico"
      }
      link: {
        label: "Facebook {{ value }}"
        url: "http://www.google.com/search?q={{ value }}"
        icon_url: "http://google.com/favicon.ico"
      }
    }

    dimension: brand_url {
      type: string
      sql:"http://www.google.com/search?q="{{ brand._value }}  ;;



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

#   dimension: product_image {
#     sql: ${brand} ;;
#     type: string
#     html:  <img height=100 width=100 src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Levis-logo-quer.svg/1200px-Levis-logo-quer.svg.png" alt="Your Alt Tag is Here"/> ;;
#   }


#   dimension: product_image {
#     sql: ${brand} ;;
#     type: string
#     html:  <div style=width:image width px; font-size:80%; text-align:bottom;>
# <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Levis-logo-quer.svg/1200px-Levis-logo-quer.svg.png" width=100 height=100 style=padding-bottom:0.5em; <caption align="bottom">Caption</caption>div>
# ;;
#   }



  dimension: product_image {
    sql: ${brand} ;;
    type: string
    html:  <div style="width:image width px; font-size:80%; text-align:centre;">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Levis-logo-quer.svg/1200px-Levis-logo-quer.svg.png"  width=100 height=100 style="padding-bottom:0.5em;" /> {{ _user_attributes['country'] }}</div>
;;
  }

  # measure: count_with_filter {
  #   type: count
  #   filters: {
  #     field: sku
  #     value: "Test"
  #   }
  # }

  # measure: count_with_filter_drill {
  #   type: count_distinct
  #   sql: ${count_with_filter} ;;
  #   filters: {
  #     field: sku
  #     value: "Test2"
  #   }
  # }




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
