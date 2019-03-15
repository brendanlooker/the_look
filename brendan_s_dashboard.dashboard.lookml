- dashboard: brendans_dash
  title: Brendans Dash
  layout: newspaper
  elements:
  - name: Average Elevation All Airports
    title: Average Elevation All Airports
    model: faa
    explore: airports
    type: single_value
    fields:
    - airports.average_elevation
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: "#57BEBE"
    show_single_value_title: true
    single_value_title: Average Airport Elevation
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 6
    width: 7
    height: 3
  - name: Cancelled Flights by Month
    title: Cancelled Flights by Month
    model: faa
    explore: flights
    type: looker_line
    fields:
    - flights.count
    - flights.depart_week
    fill_fields:
    - flights.depart_week
    filters:
      flights.depart_year: '2004'
      flights.cancelled: Y
    sorts:
    - flights.depart_week
    limit: 500
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: circle_outline
    limit_displayed_rows: false
    y_axes:
    - label: Number of Cancelled Flights
      orientation: left
      series:
      - id: flights.count
        name: Flights Count
        axisId: flights.count
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: custom
      tickDensityCustom: 39
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Departure Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines:
    - reference_type: line
      line_value: mean
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: right
      color: "#57BEBE"
      label: Average
    - reference_type: line
      line_value: max
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: center
      color: purple
      label: Max
    - reference_type: line
      line_value: min
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: left
      color: "#EA8A2F"
      label: Min
    show_null_points: true
    interpolation: linear
    row: 3
    col: 6
    width: 18
    height: 6
  - name: Cancelled Flights by Year
    title: Cancelled Flights by Year
    model: faa
    explore: flights
    type: table
    fields:
    - flights.cancelled_count
    - flights.depart_week
    fill_fields:
    - flights.depart_week
    filters:
      flights.cancelled: Y
      flights.depart_year: '2004'
    sorts:
    - flights.depart_week desc
    limit: 500
    column_limit: 50
    listen:
      YearFilter: flights.arrival_year
    row: 9
    col: 6
    width: 8
    height: 6
  - name: Top 10 Airport Count by State
    title: Top 10 Airport Count by State
    model: faa
    explore: airports
    type: looker_column
    fields:
    - airports.state
    - airports.count
    sorts:
    - airports.count desc
    limit: 10
    column_limit: 50
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: Airports
      orientation: left
      series:
      - id: airports.count
        name: Airports Count
        axisId: airports.count
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: State
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    custom_color: "#8365ff"
    show_single_value_title: true
    single_value_title: Total Number of Airports
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 0
    width: 6
    height: 16
  - name: Top 10 Airports by State
    title: Top 10 Airports by State
    model: faa
    explore: airports
    type: looker_column
    fields:
    - airports.state
    - airports.count
    sorts:
    - airports.count desc
    limit: 10
    column_limit: 50
    query_timezone: America/New_York
    stacking: ''
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: Airport Count
      orientation: left
      series:
      - id: airports.count
        name: Airports Count
        axisId: airports.count
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: custom
      tickDensityCustom: 37
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: State
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    custom_color: "#7b8bff"
    show_single_value_title: true
    single_value_title: Total Airports
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 9
    col: 14
    width: 8
    height: 6
  - name: Flights by Month
    title: Flights by Month
    model: faa
    explore: flights
    type: looker_line
    fields:
    - flights.count
    - flights.depart_month_name
    fill_fields:
    - flights.depart_month_name
    filters:
      flights.depart_year: '2000'
    sorts:
    - flights.depart_month_name
    limit: 500
    query_timezone: America/New_York
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: Flights
      orientation: left
      series:
      - id: flights.count
        name: Flights Count
        axisId: flights.count
      showLabels: true
      showValues: true
      valueFormat: ''
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    row: 0
    col: 13
    width: 11
    height: 3
  filters:
  - name: YearFilter
    title: YearFilter
    type: date_filter
    default_value: '2004'
    allow_multiple_values: true
    required: false
