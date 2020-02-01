# Infraxys module AWS S3

This module helps to manage S3 related resources

## Bash functions

### ensure_bucket_exists

Tries to ensure that a bucket exists in the current account.  
`aws s3api head-bucket` is used to determine if the bucket already exists.

#### Arguments

| Name | Required | Default | Description |
| ---- | -------- | ------- | ----------- |
| bucket | yes | | Name of the bucket |
| region | yes | | AWS region for the bucket |
| exit_on_forbidden | no | false | Exit with status code 1 if a 403-forbidden is returned while trying to execute HeadObject on the bucket |
| exit_on_error | no | true | Exit with status code 1 if in other than 403-error occurs while executing HeadObject on the bucket |
 

#### Example

```bash
ensure_bucket_exists --bucket "$bucket" --region "$aws_region";
```

'bucket' and 'aws_region' are packet attributes of the currently executing action.
