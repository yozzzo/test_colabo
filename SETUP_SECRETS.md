# Colab シークレット設定ガイド

Google Colabでノートブックを安全に実行するための設定手順です。

## 🔐 必要なシークレット

1. **NGROK_AUTHTOKEN** - ngrokのアカウントトークン
2. **API_KEY** - APIアクセス用の認証キー

## 📝 設定手順

### 1. ngrokトークンの取得

1. [ngrok](https://dashboard.ngrok.com/signup)でアカウント作成
2. ダッシュボードにログイン
3. [Your Authtoken](https://dashboard.ngrok.com/auth)ページからトークンをコピー

### 2. Colabでシークレットを設定

#### 方法1: Colabの設定画面から（推奨）

1. Colabでノートブックを開く
2. 左サイドバーの**鍵アイコン**（🔑）をクリック
3. 「**シークレットを追加**」をクリック
4. 以下の2つのシークレットを追加：

   | 名前 | 値 |
   |------|-----|
   | `NGROK_AUTHTOKEN` | ngrokダッシュボードからコピーしたトークン |
   | `API_KEY` | 任意の安全な文字列（例: `sk-proj-abc123xyz789`） |

#### 方法2: ノートブック実行時に設定

ノートブックを実行すると、以下のような警告が表示されます：

```
⚠️  Warning: Could not load secrets from Colab userdata
Please set NGROK_AUTHTOKEN and API_KEY in Colab secrets
Settings → Secrets → Add new secret
```

この場合も上記の手順でシークレットを追加してください。

### 3. APIキーの生成（推奨）

安全なAPIキーを生成する方法：

```python
import secrets
print(f"API_KEY: sk-proj-{secrets.token_urlsafe(32)}")
```

## 🔍 設定の確認

シークレットが正しく設定されているか確認：

```python
from google.colab import userdata

try:
    ngrok_token = userdata.get('NGROK_AUTHTOKEN')
    api_key = userdata.get('API_KEY')
    print("✅ シークレットが正しく設定されています")
except:
    print("❌ シークレットが見つかりません")
```

## 📌 重要な注意事項

1. **シークレットはセッション毎に保持される**
   - 一度設定すれば、同じセッション中は再設定不要
   - ランタイムをリセットしても保持される

2. **シークレットは共有されない**
   - ノートブックを他の人と共有しても、シークレットは共有されない
   - 各ユーザーが自分のシークレットを設定する必要がある

3. **セキュリティのベストプラクティス**
   - APIキーは定期的に変更する
   - 本番環境では強力なAPIキーを使用
   - シークレットをコードに直接書かない

## 🚀 実行方法

1. 上記の手順でシークレットを設定
2. ノートブックの全セルを実行
3. エラーが出た場合は、シークレットが正しく設定されているか確認

## 🆘 トラブルシューティング

### "NGROK_AUTHTOKEN not found in Colab secrets"エラー

- 鍵アイコンからシークレットを追加
- 名前は正確に`NGROK_AUTHTOKEN`（大文字）で入力

### APIキー認証エラー

- `API_KEY`シークレットが設定されているか確認
- APIリクエスト時に同じキーを使用しているか確認

### シークレットが読み込めない

- ランタイムを再起動して再試行
- Colabの設定画面から直接追加