#!/bin/bash
set -e

echo "========================================="
echo "  Hoichoi IPTV - Setup Script"
echo "========================================="

if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and Docker Compose first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "Docker Compose is not installed."
    exit 1
fi

if [ ! -f .env ]; then
    echo "Creating .env from .env.example..."
    cp .env.example .env
    echo ".env file created. Please review and update the configuration."
fi

echo "Building and starting services..."
if docker compose version &> /dev/null 2>&1; then
    docker compose up -d --build
else
    docker-compose up -d --build
fi

echo "Waiting for MySQL to be ready..."
sleep 10

echo "Importing database schema..."
docker exec -i hoichoi-mysql mysql -u root -ppassword hoichoi_iptv < database/schema.sql 2>/dev/null || echo "Schema import may have already been applied."

echo ""
echo "========================================="
echo "  Hoichoi IPTV is now running!"
echo "========================================="
echo ""
echo "  Frontend:  http://localhost:3000"
echo "  Backend:   http://localhost:5000/api"
echo "  Admin:     http://localhost:3000/admin"
echo ""
echo "  Default Admin Login:"
echo "  Email:    admin@hoichoi.com"
echo "  Password: Admin@123"
echo ""
