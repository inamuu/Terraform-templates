variable "autoscaling_schedules" {
  type = map(object({
    start_time             = string
    stop_time              = string
    start_min_size         = number
    start_max_size         = number
    start_desired_capacity = number
    end_min_size           = number
    end_max_size           = number
    end_desired_capacity   = number
    time_zone              = string
  }))
}

