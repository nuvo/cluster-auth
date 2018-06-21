resource "aws_iam_group" "group" {
  name = "${var.name}"
}

resource "aws_iam_user" "user" {
  count = "${length(var.users)}"
  name  = "${var.users[count.index]}"
}

resource "aws_iam_access_key" "key" {
  count = "${length(var.users)}"
  user  = "${var.users[count.index]}"
}

resource "aws_iam_user_group_membership" "membership" {
  count = "${length(var.users)}"
  user  = "${var.users[count.index]}"

  groups = [
    "${var.name}",
  ]
}
