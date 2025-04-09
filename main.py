import json
from pathlib import Path

import yaml

from models import ServiceList

SERVICES_YAML = Path("services.yaml")
ONBOARDING_OUTPUT = Path(
    "terraform/envs/onboarding/service_inputs.auto.tfvars.json"
)
ONBOARDING_ENV_DIR = Path("terraform/envs/onboarding")


def load_and_validate_services() -> ServiceList:
    with open(SERVICES_YAML, "r") as f:
        raw = yaml.safe_load(f)
    return ServiceList(**raw)


def build_onboarding_payload(data: ServiceList):
    output = {}
    for svc in data.services:
        output[svc.name] = {}
        for env_name, env_cfg in svc.environments.items():
            output[svc.name]["environments"] = dict()
            output[svc.name]["environments"][env_name] = dict()
            if env_cfg.dns:
                output[svc.name]["environments"][env_name] = {
                    "dns": [record.model_dump() for record in env_cfg.dns]
                }
    return output


def write_tfvars_file(payload: dict):
    ONBOARDING_OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    with open(ONBOARDING_OUTPUT, "w") as f:
        json.dump(payload, f, indent=2)
    print(f"✅ Generated: {ONBOARDING_OUTPUT}")


# Deprecated:
# TODO: Remove Later
# def run_terraform_onboarding():
#     print("🚀 Running Terraform in onboarding env...")
#     try:
#         subprocess.run(["terraform", "init"], cwd=ONBOARDING_ENV_DIR, check=True)
#         subprocess.run(
#             ["terraform", "apply", "-auto-approve", f"-var-file={ONBOARDING_OUTPUT.name}"],
#             cwd=ONBOARDING_ENV_DIR,
#             check=True
#         )
#         print("✅ Terraform apply successful.")
#     except subprocess.CalledProcessError as e:
#         print(f"❌ Terraform failed: {e}")


def main():
    try:
        validated = load_and_validate_services()
    except Exception as e:
        print(f"❌ Validation failed: {e}")
        return

    payload = {
        "services": build_onboarding_payload(validated),
    }
    write_tfvars_file(payload)
    # run_terraform_onboarding() # TODO: Remove Dead Code

    # TODO: Remove Dead Code
    # if Path.exists(ONBOARDING_OUTPUT):
    #     os.remove(ONBOARDING_OUTPUT)


if __name__ == "__main__":
    main()
