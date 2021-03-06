resource "aws_s3_bucket" "expn-cis-bis-sandbox-dev-logs-us-east-1" {
  bucket = "expn-cis-bis-sandbox-dev-logs-us-east-1"
  acl    = "private"
  tags = {
    Name        = "expn-cis-bis-sandbox-dev-logs-us-east-1"
    Client      = "Internal"
    Project     = "bis-sandbox-dev Dedicated - S3"
    Environment = "Dev"
    Owner       = "Gopi Chand Mummineni"
    Application = "S3"
    FundingInitiatives = "Ascend-PaaS"
    CostIncurred = "Experian"
  }
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-cis-bis-sandbox-dev-logs-us-east-1",
     "Statement": [
        {
            "Sid": "Stmt1549652347458",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                     "arn:aws:iam::${var.ascend-bis-sandbox-dev-account-id}:root",
                     "arn:aws:iam::${var.ascend-bis-sandbox-dev-account-id}:role/bis-sandbox-dev-basic-instance-role"
                ]
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::expn-cis-bis-sandbox-dev-logs-us-east-1",
                "arn:aws:s3:::expn-cis-bis-sandbox-dev-logs-us-east-1/*"
            ]
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-cis-bis-sandbox-dev-data-us-east-1" {
  bucket = "expn-cis-bis-sandbox-dev-data-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-cis-bis-sandbox-dev-data-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-data-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-data-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-data-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}


resource "aws_s3_bucket" "expn-cis-bis-sandbox-dev-config-us-east-1" {
  bucket = "expn-cis-bis-sandbox-dev-config-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-cis-bis-sandbox-dev-config-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-config-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-config-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-config-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-cis-bis-sandbox-dev-devops-us-east-1" {
  bucket = "expn-cis-bis-sandbox-dev-devops-us-east-1"
  acl    = "private"
  tags = {
    Name        = "expn-cis-bis-sandbox-dev-devops-us-east-1"
    Client      = "Internal"
    Project     = "bis-sandbox-dev Dedicated - S3"
    Environment = "Dev"
    Owner       = "Gopi Chand Mummineni"
    Application = "S3"
    FundingInitiatives = "Ascend-PaaS"
    CostIncurred = "Experian"
  }
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-cis-bis-sandbox-dev-devops-us-east-1",
     "Statement": [
        {
            "Sid": "Stmt1549652347458",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                     "arn:aws:iam::${var.ascend-bis-sandbox-dev-account-id}:root",
                    "arn:aws:iam::${var.ascend-bis-sandbox-dev-account-id}:role/bis-sandbox-dev-basic-instance-role"
                ]
            },
            "Action": [
                "s3:GetObject",
                "s3:ListBucket",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::expn-cis-bis-sandbox-dev-devops-us-east-1",
                "arn:aws:s3:::expn-cis-bis-sandbox-dev-devops-us-east-1/*"
            ]
        },
        {
           "Sid": "Stmt1549652347459",
           "Effect": "Allow",
           "Principal": {
               "AWS": "arn:aws:iam::581463129500:role/AWSCodedeployAscendPaas"
           },
           "Action": [
               "s3:GetObject",
               "s3:PutObject",
               "s3:PutObjectAcl"
           ],
           "Resource": "arn:aws:s3:::expn-cis-bis-sandbox-dev-devops-us-east-1/*"
       }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-bis-ascend-sandbox-crdb-dev-us-east-1" {
  bucket = "expn-bis-ascend-sandbox-crdb-dev-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-bis-ascend-sandbox-crdb-dev-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-crdb-dev-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-crdb-dev-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-crdb-dev-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-bis-ascend-sandbox-sbcs-dev-us-east-1" {
  bucket = "expn-bis-ascend-sandbox-sbcs-dev-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-bis-ascend-sandbox-sbcs-dev-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-sbcs-dev-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-sbcs-dev-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-sbcs-dev-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-bis-ascend-sandbox-sbfe-dev-us-east-1" {
  bucket = "expn-bis-ascend-sandbox-sbfe-dev-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-bis-ascend-sandbox-sbfe-dev-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-sbfe-dev-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-sbfe-dev-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-sbfe-dev-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-bis-ascend-sandbox-input-dev-us-east-1" {
  bucket = "expn-bis-ascend-sandbox-input-dev-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-bis-ascend-sandbox-input-dev-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-input-dev-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-input-dev-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-input-dev-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "expn-bis-ascend-sandbox-data-dev-us-east-1" {
  bucket = "expn-bis-ascend-sandbox-data-dev-us-east-1"
  acl    = "private"

  tags = {
    Name        = "bis-sandbox-dev"
    Client      = "bis-sandbox-dev"
    Project     = "bis-sandbox-dev-logs"
    Environment = "Dev"
    Owner       = "Gopi"
    Application = "logs"


}
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
}

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyexpn-expn-bis-ascend-sandbox-data-dev-us-east-1",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-data-dev-us-east-1/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-data-dev-us-east-1/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        },
        {
            "Sid": "DenyNonSSLAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::expn-bis-ascend-sandbox-data-dev-us-east-1/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}
