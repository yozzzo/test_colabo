# Google Colab Quick Start

## 最新版を確実に実行する方法

### 方法1: ワンライナー（推奨）

Colabの新しいセルで以下を実行：

```python
!rm -rf /content/test_colabo_latest && git clone https://github.com/yozzzo/test_colabo.git /content/test_colabo_latest && cp /content/test_colabo_latest/gaussian_splatting_api.ipynb /content/
```

その後、File → Open notebook → gaussian_splatting_api.ipynb を開く

### 方法2: 直接URLから開く

以下のURLをクリック：
https://colab.research.google.com/github/yozzzo/test_colabo/blob/master/gaussian_splatting_api.ipynb

### 方法3: スクリプトで実行

```python
# 最新版を取得して実行
import subprocess
subprocess.run(['rm', '-rf', '/content/test_colabo_latest'])
subprocess.run(['git', 'clone', 'https://github.com/yozzzo/test_colabo.git', '/content/test_colabo_latest'])
subprocess.run(['cp', '/content/test_colabo_latest/gaussian_splatting_api.ipynb', '/content/'])
print("✅ Latest version copied to /content/gaussian_splatting_api.ipynb")
```

## 確認方法

最新版かどうか確認するには、セル3を見て以下のコードになっているか確認：

```python
# Simple COLMAP installation for Google Colab
print("Installing COLMAP via apt-get...")
```

古いバージョンの場合は `colmap-3.8-linux-cuda.tar.gz` をダウンロードしようとします。

## トラブルシューティング

1. **ランタイムをリセット**: Runtime → Disconnect and delete runtime
2. **ブラウザキャッシュをクリア**: Ctrl+Shift+R (Windows/Linux) or Cmd+Shift+R (Mac)
3. **別のブラウザで開く**: 時々Colabがキャッシュを保持することがある
4. **プライベートブラウジングモードで開く**: キャッシュの影響を受けない

## テストの実行

最新版で実行後、新しいURLでテスト：

```bash
export PUBLIC_URL='https://xxxx.ngrok-free.app'
export API_KEY='sk-proj-bXlfc29tZXJhbmRvbXN0cmluZ2hlcmU'
./test_gaussian_splatting.sh
```