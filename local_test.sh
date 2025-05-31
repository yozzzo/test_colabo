#!/bin/bash

# Local test script for GPU API
# Usage: ./local_test.sh

# Check if PUBLIC_URL is set
if [ -z "$PUBLIC_URL" ]; then
    echo "Error: PUBLIC_URL environment variable not set"
    echo "Export it from the Colab notebook output:"
    echo "export PUBLIC_URL='https://xxxx-xx-xx-xx-xx.ngrok-free.app'"
    exit 1
fi

# API key (must match the one in the notebook)
API_KEY="foo"

# Test file
TEST_FILE="sample.mp4"

# Check if test file exists
if [ ! -f "$TEST_FILE" ]; then
    echo "Creating sample test file: $TEST_FILE"
    # Create a small sample video file for testing
    echo "This is a sample file for testing" > "$TEST_FILE"
fi

echo "Testing GPU API at: $PUBLIC_URL"
echo "================================"

# Test health check endpoint
echo "1. Testing health check endpoint..."
curl -s "$PUBLIC_URL/" | jq . || echo "Health check failed"

echo -e "\n2. Testing file upload endpoint..."
# Test file upload
RESPONSE=$(curl -s -X POST "$PUBLIC_URL/generate" \
    -H "API_KEY: $API_KEY" \
    -F "file=@$TEST_FILE")

echo "Response:"
echo "$RESPONSE" | jq . || echo "$RESPONSE"

# Extract download URL if successful
if echo "$RESPONSE" | grep -q "download_url"; then
    DOWNLOAD_URL=$(echo "$RESPONSE" | jq -r .download_url)
    echo -e "\n✅ Success! File processed."
    echo "Download URL: $DOWNLOAD_URL"
else
    echo -e "\n❌ Upload failed"
fi

echo -e "\n================================"
echo "Test complete!"