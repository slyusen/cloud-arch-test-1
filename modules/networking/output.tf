output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnet_ids" {
  value = "${aws_subnet.public_subnet.*.id}"
}
output "private_subnet_ids" {
  value = "${aws_subnet.private_subnet.*.id}"
}
output "alb_security_group_id" {
  value = "${aws_security_group.lb.id}"
}
output "ecs_tasks_security_group_id" {
  value = "${aws_security_group.ecs_tasks.id}"
}