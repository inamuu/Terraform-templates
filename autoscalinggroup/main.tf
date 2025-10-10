resource "aws_autoscaling_schedule" "scale_out" {
  for_each               = var.autoscaling_schedules
  scheduled_action_name  = "example-${each.key}-scale-out"
  autoscaling_group_name = "example-${each.key}-cluster"
  min_size               = each.value.start_min_size
  max_size               = each.value.start_max_size
  desired_capacity       = each.value.start_desired_capacity
  recurrence             = each.value.start_time
  time_zone              = each.value.time_zone
}

resource "aws_autoscaling_schedule" "scale_in" {
  for_each               = var.autoscaling_schedules
  scheduled_action_name  = "example-${each.key}-scale-out"
  autoscaling_group_name = "example-${each.key}-cluster"
  min_size               = each.value.end_min_size
  max_size               = each.value.end_max_size
  desired_capacity       = each.value.end_desired_capacity
  recurrence             = each.value.stop_time
  time_zone              = each.value.time_zone
}

