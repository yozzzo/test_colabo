# GPU API on Google Colab

Deploy a FastAPI server on Google Colab with GPU acceleration for heavy processing tasks.

## Features

- 🚀 FastAPI server with automatic API documentation
- 🔌 Public URL via ngrok tunnel (free tier)
- 🎯 GPU-accelerated processing (placeholder for your code)
- 💾 Google Drive integration for persistent storage
- 🔐 Basic API key authentication
- 📦 File upload/download endpoints

## Setup Instructions

### 1. Prerequisites

- Google account with Colab access
- ngrok account (free tier): https://dashboard.ngrok.com/signup
- Google Drive with available storage

### 2. Configuration

1. **Get ngrok auth token**:
   - Sign up at https://dashboard.ngrok.com/signup
   - Copy your auth token from https://dashboard.ngrok.com/auth

2. **Open the notebook in Colab**:
   - Upload `colab_gpu_api.ipynb` to Google Colab
   - Switch to GPU runtime: Runtime → Change runtime type → GPU

3. **Set up Colab Secrets** (NEW - Secure Method):
   - Click the 🔑 (key) icon in the left sidebar
   - Add the following secrets:
     - `NGROK_AUTHTOKEN`: Your ngrok auth token
     - `API_KEY`: A secure API key (e.g., `sk-proj-abc123xyz789`)
   - See [SETUP_SECRETS.md](SETUP_SECRETS.md) for detailed instructions

### 3. Running the API

1. Run all cells in order
2. When prompted, authorize Google Drive access
3. The notebook will print your public URL:
   ```
   🚀 API is live at: https://xxxx-xx-xx-xx-xx.ngrok-free.app
   ```

4. Keep the last cell running to maintain the connection

### 4. Testing the API

From your local machine:

```bash
# Set the public URL from Colab output
export PUBLIC_URL='https://xxxx-xx-xx-xx-xx.ngrok-free.app'

# Run the test script
./local_test.sh
```

Or manually with curl:

```bash
curl -X POST $PUBLIC_URL/generate \
  -H "API_KEY: foo" \
  -F "file=@sample.mp4"
```

## API Endpoints

### Health Check
```
GET /
```

### Generate (Process File)
```
POST /generate
Headers: API_KEY: <your-api-key>
Body: multipart/form-data with file
```

Response:
```json
{
  "status": "success",
  "download_url": "/content/drive/MyDrive/gpu_api_outputs/output_20240131_123456_sample.mp4",
  "filename": "output_20240131_123456_sample.mp4",
  "processed_at": "2024-01-31T12:34:56.789123"
}
```

## Important Limitations & Caveats

### GPU Runtime Limits

- **Free Tier**: ~12 hours max session time
- **Idle Timeout**: ~90 minutes of inactivity
- **Daily Limits**: Variable based on usage and availability
- **GPU Type**: Usually Tesla T4 (free tier)

### Cost Considerations

- **Colab Free**: Limited GPU time, may be interrupted
- **Colab Pro ($10/mo)**: Priority GPU access, longer runtimes
- **Colab Pro+ ($50/mo)**: Best GPUs, longest runtimes

### Network Limitations

- **ngrok Free**: 
  - 1 online tunnel
  - Random URL (changes each session)
  - 40 connections/minute limit
- **ngrok Paid**: Custom domains, higher limits

### Storage

- Files saved to Google Drive persist after session ends
- Temporary files in `/tmp` are lost on disconnect
- Drive has 15GB free tier limit

## Customization

### Add Your GPU Processing Code

Replace the `process_with_gpu()` function in cell 3:

```python
def process_with_gpu(input_path: Path, output_path: Path):
    # Your actual GPU processing code here
    # Example: Load model, process input, save output
    pass
```

### Production Considerations

1. **Authentication**: Implement proper OAuth2/JWT instead of API keys
2. **File Management**: Add cleanup routines for old files
3. **Error Handling**: Add comprehensive logging and error recovery
4. **Monitoring**: Track GPU usage and processing times
5. **Scaling**: Consider cloud GPU services for production

## Troubleshooting

### "No GPU available"
- Change runtime type to GPU in Colab
- Check GPU availability in free tier

### ngrok connection failed
- Verify auth token is correct
- Check if you have other tunnels running
- Try restarting the runtime

### Drive mount issues
- Re-authorize Google Drive access
- Check available Drive storage
- Verify output directory permissions

### API timeout
- Increase processing limits for large files
- Implement async background processing
- Add progress endpoints for long tasks

## Security Notes

⚠️ **Never commit**:
- ngrok auth tokens
- API keys
- Google credentials
- Any sensitive data

Always use environment variables or secure vaults for production deployments.