"""
Stateless Portfolio API Service
Exposes health endpoints, metadata, and structured JSON logs.
"""
import os
import sys
import time
import logging
import json
from fastapi import FastAPI, Response, status

# Configure structured JSON logging
class JSONFormatter(logging.Formatter):
    def format(self, record):
        log_obj = {
            "timestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime(record.created)),
            "level": record.levelname,
            "message": record.getMessage(),
            "module": record.module,
        }
        return json.dumps(log_obj)

handler = logging.StreamHandler(sys.stdout)
handler.setFormatter(JSONFormatter())
logger = logging.getLogger("portfolio-app")
logger.setLevel(logging.INFO)
logger.addHandler(handler)
logger.propagate = False

app = FastAPI(
    title="AWS EKS GitOps Portfolio Service",
    description="Stateless microservice deployed to Amazon EKS via Argo CD",
    version=os.getenv("APP_VERSION", "1.0.0")
)

@app.get("/")
def read_root():
    """Homepage endpoint returning service identity and version."""
    logger.info("Serving root homepage request")
    return {
        "status": "online",
        "project": "AWS EKS Platform — Terraform + GitOps",
        "version": os.getenv("APP_VERSION", "1.0.0"),
        "environment": os.getenv("ENVIRONMENT", "dev"),
        "cluster_platform": "Amazon EKS"
    }

@app.get("/healthz", status_code=status.HTTP_200_OK)
def liveness_probe():
    """Liveness probe: verifies process is alive and responsive."""
    return {"status": "healthy"}

@app.get("/readyz", status_code=status.HTTP_200_OK)
def readiness_probe(response: Response):
    """Readiness probe: verifies service is ready to accept user traffic."""
    return {"status": "ready"}