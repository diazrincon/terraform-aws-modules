#!/bin/bash

# Retrieve IMDSv2 token
IMDS_TOKEN=$(curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds: 120" -H "Content-Type: text/plain" http://169.254.169.254/latest/api/token)

# Use IMDSv2 token to fetch instance metadata
export EC2_REGION=$(curl -sSL -H "X-aws-ec2-metadata-token: $IMDS_TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
export EC2_INSTANCE=$(curl -sSL -H "X-aws-ec2-metadata-token: $IMDS_TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
aws configure set region $EC2_REGION
LAST2OCTETS=$(curl -H "X-aws-ec2-metadata-token: $IMDS_TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4 | awk 'BEGIN{OFS="-";FS="."}{print $3,$4}')
NEW_NAME="${cluster_full_name}-$LAST2OCTETS"
aws ec2 create-tags --resources $EC2_INSTANCE --tags Key=Name,Value=$NEW_NAME --region=$EC2_REGION

cat <<EOF | sudo tee /tmp/eks-config-source.yaml
---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: ${cluster_endpoint}
    certificateAuthority: ${cluster_ca}
    cidr: ${service_ipv4_cidr}
    name: ${cluster_full_name}
EOF
#/etc/eks/bootstrap.sh --b64-cluster-ca "${cluster_ca}" --apiserver-endpoint "${cluster_endpoint}" --kubelet-extra-args --v=3 "${cluster_full_name}"
sudo nodeadm config check --config-source file:///tmp/eks-config-source.yaml && sudo nodeadm init --config-source file:///tmp/eks-config-source.yaml
