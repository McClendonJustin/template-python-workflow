#!/bin/bash

# Exit immediately if any command fails
set -e

IMAGE_NAME="pytest-env"

echo "----------------------------------------"
echo "Building Docker image: $IMAGE_NAME..."
echo "----------------------------------------"
docker build -t $IMAGE_NAME .

echo "----------------------------------------"
echo "Running containerized tests..."
echo "----------------------------------------"
docker run --rm $IMAGE_NAME

echo "----------------------------------------"
echo "Done!"