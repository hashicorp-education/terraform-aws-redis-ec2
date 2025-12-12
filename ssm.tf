data "aws_secretsmanager_secret" "redis" {
  name = "${var.waypoint_application}-redis"
}


resource "aws_secretsmanager_secret_version" "redis" {
  secret_id = data.aws_secretsmanager_secret.redis.id
  secret_string = jsonencode({
    redis_ip       = aws_instance.web.public_ip
    redis_port     = "6379"
    redis_password = random_string.redis_password.id
  })
}