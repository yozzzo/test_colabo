#!/bin/bash

# Test script for 3D Gaussian Splatting API
# Usage: ./test_gaussian_splatting.sh

# Check if PUBLIC_URL is set
if [ -z "$PUBLIC_URL" ]; then
    echo "Error: PUBLIC_URL environment variable not set"
    echo "Export it from the Colab notebook output:"
    echo "export PUBLIC_URL='https://xxxx-xx-xx-xx-xx.ngrok-free.app'"
    exit 1
fi

# Check if API_KEY is set
if [ -z "$API_KEY" ]; then
    echo "Error: API_KEY environment variable not set"
    echo "Export it from the Colab notebook output:"
    echo "export API_KEY='your-secure-api-key-here'"
    exit 1
fi

echo "Testing 3D Gaussian Splatting API at: $PUBLIC_URL"
echo "============================================"

# Test health check
echo "1. Testing health check endpoint..."
curl -s "$PUBLIC_URL/" | jq . || echo "Health check failed"

# Check what test files are available
if [ -f "sample.mp4" ]; then
    echo -e "\n2. Using existing sample.mp4 for testing..."
    TEST_MODE="video"
    
    # Test with video
    echo -e "\n3. Testing with video file (this may take 10-30 minutes)..."
    echo "Uploading video and extracting frames for 3D reconstruction..."
    
    RESPONSE=$(curl -s -X POST "$PUBLIC_URL/process" \
        -H "Api-Key: $API_KEY" \
        -F "files=@sample.mp4" \
        -F "extract_fps=2" \
        -F "iterations=1000")
    
elif [ -f "test_image_1.jpg" ] && [ -f "test_image_2.jpg" ] && [ -f "test_image_3.jpg" ]; then
    echo -e "\n2. Using existing test images..."
    TEST_MODE="images"
    
    # Test with multiple images
    echo -e "\n3. Testing with multiple images (this may take 10-30 minutes)..."
    echo "Uploading images and starting 3D reconstruction..."
    
    RESPONSE=$(curl -s -X POST "$PUBLIC_URL/process" \
        -H "Api-Key: $API_KEY" \
        -F "files=@test_image_1.jpg" \
        -F "files=@test_image_2.jpg" \
        -F "files=@test_image_3.jpg" \
        -F "iterations=1000")
else
    echo -e "\n2. Creating test images..."
    # Create simple test images using ImageMagick (if available)
    if command -v convert &> /dev/null; then
        convert -size 640x480 xc:red -pointsize 60 -draw "text 100,240 'View 1'" test_image_1.jpg
        convert -size 640x480 xc:green -pointsize 60 -draw "text 100,240 'View 2'" test_image_2.jpg
        convert -size 640x480 xc:blue -pointsize 60 -draw "text 100,240 'View 3'" test_image_3.jpg
        echo "Created 3 test images"
        TEST_MODE="images"
        
        # Test with created images
        echo -e "\n3. Testing with multiple images (this may take 10-30 minutes)..."
        echo "Uploading images and starting 3D reconstruction..."
        
        RESPONSE=$(curl -s -X POST "$PUBLIC_URL/process" \
            -H "Api-Key: $API_KEY" \
            -F "files=@test_image_1.jpg" \
            -F "files=@test_image_2.jpg" \
            -F "files=@test_image_3.jpg" \
            -F "iterations=1000")
    else
        echo "No test files found. Please provide either:"
        echo "  - sample.mp4 (video file)"
        echo "  - test_image_1.jpg, test_image_2.jpg, test_image_3.jpg (at least 3 images)"
        exit 1
    fi
fi

echo -e "\nResponse:"
echo "$RESPONSE" | jq . || echo "$RESPONSE"

# Extract job ID if successful
if echo "$RESPONSE" | grep -q "job_id"; then
    JOB_ID=$(echo "$RESPONSE" | jq -r .job_id)
    MODEL_FILE=$(echo "$RESPONSE" | jq -r .model_file)
    echo -e "\n✅ Success!"
    echo "Job ID: $JOB_ID"
    echo "Model file: $MODEL_FILE"
    echo "Check Google Drive for the output files"
else
    echo -e "\n❌ Processing failed"
fi

echo -e "\n============================================"
echo "Test complete!"

# Optional: Test with video
echo -e "\n4. (Optional) Test with video file"
echo "To test with video, run:"
echo "curl -X POST \$PUBLIC_URL/process -H \"Api-Key: \$API_KEY\" -F \"files=@video.mp4\" -F \"extract_fps=2\" -F \"iterations=1000\""