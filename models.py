from typing import Dict, List, Optional, Self

from pydantic import BaseModel, Field, field_validator, model_validator


class DNSRecord(BaseModel):
    type: str
    name: str
    value: Optional[str] = None
    ttl: int = Field(
        default=3600, ge=60, le=86400, description="Time to live in seconds"
    )
    priority: Optional[int] = None

    @classmethod
    def priority_should_be_non_null(cls, priority, type):
        for_types = ["MX", "SRV", "URI"]
        if (type in for_types) and (priority is None):
            raise ValueError(
                f"Priority cannot be blank for records of type {",".join(for_types)}"
            )
        return priority

    @field_validator("type", mode="after")
    @classmethod
    def validate_type(cls, v):
        allowed = {"A", "CNAME", "TXT", "MX"}
        if v not in allowed:
            raise ValueError(f"Invalid DNS record type: {v}")
        return v

    @classmethod
    def value_required_for_non_a(cls, value, type):
        if type != "A" and not value:
            raise ValueError(f"DNS record of type {type} requires 'value'")
        return value

    @model_validator(mode="after")
    def perform_validations(self) -> Self:
        self.value = self.value_required_for_non_a(self.value, self.type)
        self.priority = self.priority_should_be_non_null(
            self.priority, self.type
        )
        return self


class EnvironmentConfig(BaseModel):
    ec2_host: str
    dns: Optional[List[DNSRecord]] = []


class Service(BaseModel):
    name: str
    repo: str
    environments: Dict[str, EnvironmentConfig]
    tags: Optional[Dict[str, str]] = {}


class ServiceList(BaseModel):
    services: List[Service]
