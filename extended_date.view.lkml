view: extended_date {
  extension: required

  dimension: created_date {
    group_label: "group_localized"
    label: "group_localized_date_localized"
    group_item_label: "date_localized"
    type: date_time
    sql: ${created_at_date} ;;
    drill_fields: [created_week,created_month]
  }

  dimension: created_week {
    group_label: "group_localized"
    label: "group_localized_week_localized"
    group_item_label: "week_localized"
    type: date_time
    sql: ${created_at_week} ;;
  }

  dimension: created_month {
    group_label: "group_localized"
    label: "group_localized_month_localized"
    group_item_label: "month_localized"
    type: date_time
    sql: ${created_at_month} ;;
  }



  dimension: created_year {
    group_label: "group_localized"
    label: "group_localized_year_localized"
    group_item_label: "year_localized"
    type: date_time
    sql: ${created_at_year} ;;
  }

 }
