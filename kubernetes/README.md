## Dev

First, you need to connect with aws using docker image to configure aws cli.

Then launch the terraform container:
```bash
docker run -it --rm -v $PWD:/code -v ~/.aws/credentials:/root/.aws/credentials -w /code/kubernetes --entrypoint=sh hashicorp/terraform:1.13.5
```

Bootstrap terraform
```bash
terraform init
```

Generate a SSH keypair for EC2:
```bash
ssh-keygen -t rsa -b 4096 -m PEM -f ~/.ssh/kubernetes
```

```bash
terraform plan
```

```bash
terraform apply
```

Connect to the EC2 instance:
```bash
ssh -i ~/.ssh/kubernetes ec2-user@$(terraform output -raw instance_public_ip)
```