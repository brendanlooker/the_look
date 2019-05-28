include: "products.view.lkml"
view: products_extended {

  # sql_table_name: demo_db.products;;

  extends: [products]

  dimension: t1 {
    type: string
    sql: "1" ;;
  }
 }
