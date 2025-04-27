## Atlantis Server Config Files
This repo contains the files used to configure atlantis server on an EC2 Instance.
Only the members having the access to the AWS KMS Keys can decrypt this. 

## How to decrypt the `config-enc.yaml` using SOPS
```bash
export KMS_ARN="ARN of KMS Key Here"
sops --decrypt \
 --decrypt --kms $KMS_ARN \
 --encrypted-regex '^(gh-app-key|atlantis-url|gh-webhook-secret)' \
 config-enc.yaml > config-dec.yaml
``` 