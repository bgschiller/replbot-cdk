# Replbot CDK

Stand up a replbot on AWS infrastructure.

## Setup

Make sure you have an environment variable set for `REPLBOT_TOKEN` (use the instructions at https://github.com/binwiederhier/replbot#installation to get one). I use direnv to make sure it is set when I change into this directory. You'll also need to have aws credentials configured, as with `aws configure`.

## To Deploy

First, we'll make sure aws-cdk is installed and [bootstrapped](https://docs.aws.amazon.com/cdk/latest/guide/bootstrapping.html).

```bash
$ npm run build
$ npm run cdk bootstrap
```

Then deploy.

```bash
$ npm run cdk deploy
```

## Output

- `Ec2CdkStack.DownloadKeyCommand`: The command needed to download the private key that was created.
- `Ec2CdkStack.sshcommand`: The command used to connect to the instance.

## Keys and Access

A Key Pair is created as part of this project. The public key will be installed as an authorized key in the EC2 instance.

To connect to the instance:

1. Download the private key from aws secretsmanager:

    ```bash
    # This will downloaded the key as `cdk-key.pem` and grant permissions.
    $ aws secretsmanager get-secret-value --secret-id ec2-ssh-key/cdk-keypair/private --query SecretString --output text > cdk-key.pem && chmod 400 cdk-key.pem
    ```

2. SSH to the instance using the command provided from the stack's output `Ec2CdkStack.sshcommand`.

    For example:

    ```bash
    $ ssh -i cdk-key.pem -o IdentitiesOnly=yes ec2-user@1.111.11.111
    ```

    _Find the command for your specific instance in the stack's output._

## To Destroy

```bash
# Destroy all project resources.
$ cdk destroy
```

