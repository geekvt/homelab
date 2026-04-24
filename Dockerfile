# Build stage
FROM python:3.12-alpine AS builder

WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.12-alpine

WORKDIR /app

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Copy app from builder
COPY --from=builder /app /app
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S python && adduser -S python -u 1001

USER python

EXPOSE 3000

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

CMD ["python", "app.py"]
