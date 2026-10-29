# Multi-stage build for minimal container size and enhanced security
# Stage 1: Build virtual environment
FROM python:3.12-slim AS builder

WORKDIR /build

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Stage 2: Final minimal runtime image
FROM python:3.12-slim AS runner

WORKDIR /app

# Create unprivileged user with explicit UID 10001
RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -s /sbin/nologin -M appuser

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy application source code
COPY src/ /app/src/

# Set ownership to unprivileged user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER 10001

EXPOSE 8000

# Run uvicorn server bound to 0.0.0.0
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]