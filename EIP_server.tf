
resource "aws_eip" "main" {
  instance = aws_instance.main.id
  domain   = "vpc"

  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Environment = var.environment
  }
  count = var.eip_enabled ? 1 : 0
}
