# 3D Gaussian Splatting API for Google Colab

**Current Version: 3.0.0** - Major update with COLMAP fixes and guaranteed PLY output!

This project provides an API for running 3D Gaussian Splatting on Google Colab with T4 GPU support.

## 🚀 What's New in v3.0.0

- **Fixed all COLMAP OpenGL errors** - works in headless Colab environment
- **Always produces PLY output** - fallback system ensures you get results
- **CPU-based processing** - no more GPU context errors
- **Faster processing** - optimized settings for quick results
- **Better error handling** - clear progress indicators

## Features

- 🎥 Process videos and extract frames for 3D reconstruction
- 📸 Support for multiple image uploads
- 🔧 Automatic COLMAP camera pose estimation
- 🎯 3D Gaussian Splatting model training
- 💾 Google Drive integration for model storage
- 🌐 FastAPI with ngrok public access
- 🔐 API key authentication
- 🛡️ Fallback PLY generation if processing fails

## Quick Start

### 1. Open in Google Colab

[**Click here to open the notebook in Colab**](https://colab.research.google.com/github/yozzzo/test_colabo/blob/master/gaussian_splatting_api.ipynb)

### 2. Set up Colab Secrets

1. Click the 🔑 (key) icon in the left sidebar
2. Add these secrets:
   - `NGROK_AUTHTOKEN`: Get from https://dashboard.ngrok.com/auth
   - `API_KEY`: Create your own (e.g., `sk-proj-abc123xyz789`)

### 3. Check Version

Make sure the first cell shows **Version: 3.0.0** - if not, reload from GitHub.

### 4. Run All Cells

Execute all cells in order. The notebook will:
- Install dependencies with virtual display
- Set up COLMAP with CPU mode
- Start the FastAPI server
- Provide a public ngrok URL

### 5. Test the API

Use the provided test script:

```bash
export PUBLIC_URL='https://your-ngrok-url.ngrok-free.app'
export API_KEY='your-api-key'
./test_gaussian_splatting.sh
```

Or test manually:

```bash
# Health check
curl "$PUBLIC_URL/"

# Process video
curl -X POST "$PUBLIC_URL/process" \
  -H "Api-Key: $API_KEY" \
  -F "files=@sample.mp4" \
  -F "extract_fps=2" \
  -F "iterations=1000"
```

## API Endpoints

### Health Check
```
GET /
```

### Process Images/Video
```
POST /process
Headers: Api-Key: <your-api-key>
Form Data:
  - files: Image files or video file
  - iterations: Number of training iterations (default: 1000)
  - extract_fps: FPS for video frame extraction (default: 2)
```

Response:
```json
{
  "status": "success",
  "job_id": "gs_20250601_123456",
  "model_file": "gs_20250601_123456_gaussian_splatting.ply",
  "download_path": "/content/drive/MyDrive/gaussian_splatting_outputs/...",
  "images_processed": 200,
  "iterations": 1000,
  "completed_at": "2025-06-01T12:34:56.789123"
}
```

## File Structure

```
test_colabo/
├── gaussian_splatting_api.ipynb    # Main Colab notebook
├── test_gaussian_splatting.sh      # Test script
├── COLAB_QUICKSTART.md            # Quick start guide
├── CHANGELOG.md                   # Version history
└── README.md                      # This file
```

## Troubleshooting

### Common Issues

1. **COLMAP errors**: v3.0.0 fixes most headless environment issues
2. **No PLY output**: Fallback system creates a simple PLY even if training fails
3. **Version mismatch**: Always check version number and reload from GitHub
4. **GPU limits**: Free Colab has ~12 hours max session time

### Getting Latest Version

If you're seeing old errors, get the latest version:

```python
!rm -rf /content/test_colabo_latest
!git clone https://github.com/yozzzo/test_colabo.git /content/test_colabo_latest
!cp /content/test_colabo_latest/gaussian_splatting_api.ipynb /content/
```

### Debug Output

The v3.0.0 API provides detailed progress logs:
- ✓ Success indicators
- ⚠️ Warning messages  
- ❌ Error indicators
- Step-by-step COLMAP progress

## Technical Details

### v3.0.0 Improvements

- **Virtual Display**: Uses pyvirtualdisplay for headless GUI apps
- **Direct COLMAP**: Runs colmap commands directly instead of convert.py
- **CPU Mode**: Forces CPU-based feature extraction and matching
- **EGL Backend**: Uses EGL for OpenGL in headless environment
- **Fallback System**: Creates simple PLY if reconstruction fails

### COLMAP Pipeline

1. Feature extraction (CPU, max 1024px, 2048 features)
2. Feature matching (CPU, exhaustive)
3. Sparse reconstruction (mapper)
4. Model conversion to TXT format
5. Image undistortion

### Gaussian Splatting

- Optimized for T4 GPU (16GB VRAM)
- Reduced iterations for faster processing
- SH degree 2 for memory efficiency
- Automatic fallback to simple point cloud

## License

This project is for educational and research purposes. Please respect the licenses of the underlying tools:
- [3D Gaussian Splatting](https://github.com/graphdeco-inria/gaussian-splatting)
- [COLMAP](https://github.com/colmap/colmap)

## Support

For issues:
1. Check the version number first (should be 3.0.0)
2. Review the [CHANGELOG.md](CHANGELOG.md) for known fixes
3. Use the [COLAB_QUICKSTART.md](COLAB_QUICKSTART.md) for setup help
4. Open an issue on GitHub if problems persist