# EC2 Curated OS Module (Option A)

This module launches a single EC2 instance and resolves the AMI based on a curated OS selection (`var.os_image`).

## OS choices

- Amazon Linux 2, Amazon Linux 2023 (resolved via public SSM parameters)
- Windows Server 2019/2022 (Full/Core where applicable; resolved via public SSM parameters)
- Ubuntu 20.04/22.04/24.04 (resolved via AMI lookup using Canonical owner ID)
- Debian 11/12 (resolved via AMI lookup using Debian Cloud Team owner ID)

## Notes

- If you pick `architecture=arm64`, make sure `instance_type` is an ARM family (e.g., t4g, m7g, c7g, r7g). Windows selections are enforced as x86_64 only.
- This is intentionally "Option A only": curated options. No "custom AMI ID" fallback yet.
- RDS connectivity later: typically you'll attach this instance SG to the RDS SG ingress rule on the DB port.
