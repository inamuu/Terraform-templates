## Cluster
resource "aws_ecs_cluster" "staging-inamuu" {
  name = "staging-inamuu"
}

## Service
resource "aws_ecs_service" "staging-inamuu-service" {
  cluster                            = "${aws_ecs_cluster.staging-inamuu.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = "${var.aws_ecs_service_desired_count_app}"
  launch_type                        = "FARGATE"
  name                               = "staging-inamuu-service"

  lifecycle {
    ignore_changes = [
      "desired_count",
    ]

    #"task_definition",
  }

  load_balancer {
    container_name   = "staging-inamuu-app"
    container_port   = "80"
    target_group_arn = "${aws_lb_target_group.staging-inamuu-app.arn}"
  }

  network_configuration {
    subnets = [
      "${aws_subnet.staging-inamuu-app-1a.id}",
    ]

    security_groups = [
      "${aws_security_group.staging-inamuu-app.id}",
    ]
  }

  task_definition = "${aws_ecs_task_definition.staging-inamuu-task.arn}"
}

## Task Definition
resource "aws_ecs_task_definition" "staging-inamuu-task" {
  family                   = "staging-inamuu"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  cpu                      = 256
  memory                   = 512
  container_definitions    = "${file("files/task-definitions/staging-inamuu-app.json")}"
}
