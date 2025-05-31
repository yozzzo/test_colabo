# 3D Gaussian Splatting API on Google Colab

Convert images or videos into 3D Gaussian Splatting models using Google Colab's T4 GPU.

## Features

- 📸 Multi-image upload support (minimum 3 images)
- 🎥 Video upload with automatic frame extraction
- 🔮 COLMAP integration for camera pose estimation
- 🎯 3D Gaussian Splatting training
- 💾 Output saved to Google Drive (.ply files)
- 🔐 API key authentication
- 🌐 Public access via ngrok

## Setup Instructions

### 1. Prerequisites

- Google account with Colab access
- ngrok account: https://dashboard.ngrok.com/signup
- At least 3 images of the same object/scene from different angles
- T4 GPU runtime (16GB VRAM)

### 2. Configuration

1. **Get ngrok auth token**:
   - Sign up at https://dashboard.ngrok.com/signup
   - Copy your auth token

2. **Open notebook in Colab**:
   - Upload `gaussian_splatting_api.ipynb` to Google Colab
   - **IMPORTANT**: Change runtime to GPU (Runtime → Change runtime type → T4 GPU)

3. **Update configuration** (in cell 3):
   ```python
   NGROK_AUTHTOKEN = "your-ngrok-token-here"
   API_KEY = "your-secure-api-key-here"
   ```

### 3. Running the API

1. Run all cells in order (this will take 5-10 minutes for initial setup)
2. Authorize Google Drive when prompted
3. The notebook will display your public URL
4. Keep the last cell running

## API Usage

### Health Check
```bash
curl https://your-url.ngrok-free.app/
```

### Process Images
```bash
# Multiple images (recommended: 10-50 images)
curl -X POST https://your-url.ngrok-free.app/process \
  -H "API_KEY: your-api-key" \
  -F "files=@image1.jpg" \
  -F "files=@image2.jpg" \
  -F "files=@image3.jpg" \
  -F "iterations=7000"
```

### Process Video
```bash
# Extract frames from video
curl -X POST https://your-url.ngrok-free.app/process \
  -H "API_KEY: your-api-key" \
  -F "files=@video.mp4" \
  -F "extract_fps=2" \
  -F "iterations=7000"
```

### Parameters

- `files`: Image files (JPG/PNG) or video files (MP4/AVI/MOV/MKV)
- `iterations`: Training iterations (default: 7000, range: 1000-10000)
- `extract_fps`: For videos, frames per second to extract (default: 2)

## Output

The API returns:
```json
{
  "status": "success",
  "job_id": "gs_20240131_123456",
  "model_file": "gs_20240131_123456_gaussian_splatting.ply",
  "download_path": "/content/drive/MyDrive/gaussian_splatting_outputs/...",
  "full_output_zip": "gs_20240131_123456_full_output.zip",
  "images_processed": 25,
  "iterations": 7000
}
```

Files saved to Google Drive:
- `.ply` file: The 3D Gaussian Splatting model
- `.zip` file: Full training output including checkpoints

## T4 GPU Optimization

Due to T4's 16GB VRAM limitation (vs 24GB recommended):

- Images are automatically resized if too large
- Default iterations reduced to 7000 (vs 30000)
- Densification parameters optimized for memory
- Process 10-50 images for best results

## Processing Time

- Setup: 5-10 minutes (first run)
- COLMAP: 5-15 minutes (depends on image count)
- Training: 10-20 minutes (7000 iterations)
- Total: 20-45 minutes per job

## Best Practices

### Image Capture Tips
1. **Coverage**: Capture from multiple angles (360° if possible)
2. **Overlap**: 60-80% overlap between consecutive images
3. **Lighting**: Consistent lighting, avoid shadows
4. **Focus**: Sharp, in-focus images
5. **Quantity**: 20-50 images optimal for T4 GPU

### Memory Management
- For >50 images, reduce iterations
- For videos, use lower extract_fps (1-2)
- Monitor GPU memory in Colab

## Troubleshooting

### "CUDA out of memory"
- Reduce number of images
- Lower iterations (try 3000-5000)
- Restart runtime and try again

### "COLMAP failed"
- Ensure images have sufficient overlap
- Check images are not blurry
- Verify at least 3 images uploaded

### "Training failed"
- Check GPU is enabled in runtime
- Verify CUDA is available
- Reduce training iterations

## Security Notes

⚠️ **Never commit**:
- ngrok auth tokens
- API keys
- Google Drive credentials

Always use environment variables or `.env` files (gitignored) for sensitive data.

## Viewing Results

To view the generated 3D model:

1. **Online viewers**:
   - https://antimatter15.com/splat/
   - https://playcanvas.com/supersplat/editor

2. **Local viewers**:
   - Use the official Gaussian Splatting viewer
   - Import into 3D software that supports PLY

## Limitations

- T4 GPU: Limited to smaller datasets
- Free Colab: Session timeout after ~12 hours
- ngrok free: Random URL each session
- Processing time: Not real-time

## Citations

If you use this in research, please cite:
```
@Article{kerbl3Dgaussians,
  author = {Kerbl, Bernhard and Kopanas, Georgios and Leimkühler, Thomas and Drettakis, George},
  title = {3D Gaussian Splatting for Real-Time Radiance Field Rendering},
  journal = {ACM Transactions on Graphics},
  year = {2023}
}
```