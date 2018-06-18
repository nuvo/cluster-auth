output "users" {
  value = "${aws_iam_user.user.*.name}"
}

output "keys" {
  value = "${aws_iam_access_key.key.*.id}"
}

output "secrets" {
  value = "${aws_iam_access_key.key.*.secret}"
}
