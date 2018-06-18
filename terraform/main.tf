resource "aws_iam_role" "role" {
  name        = "${var.name}"
  description = "${var.description}"

  assume_role_policy = "${data.aws_iam_policy_document.grantee.json}"
}

data "aws_iam_policy_document" "grantee" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_group" "group" {
  name = "${var.name}"
}

resource "aws_iam_group_policy" "group_policy" {
  name  = "${var.name}-policy"
  group = "${aws_iam_group.group.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.name}"
    }
  ]
}
EOF
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
