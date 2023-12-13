# 關卡

## 關卡設定檔

關卡設定檔是一個 `json` 檔案，裡面包含了關卡的各種設定。  
設定檔位於 `data/settings/levels.json`。

```json
[
  {
    "title": "<關卡標題>",
    "description": "<關卡描述>",
    "timelimit": 120000,
    "background": "<背景名稱>",
    "music": "<背景音樂名稱>",
    "vocab": {
      "<單字庫序號>": 100,
    },
    "enemies": [
      {
        "mob": "<怪物名稱>",
        "moblevel": 1.0,
        "time": 120000,
        "interval": 5000,
        "count": 5,
      }
    ]
  }
]
```

- `title`: 關卡標題，用於顯示在關卡選單上
- `description`: 關卡描述，用於顯示在關卡選單上（游標移動到關卡上時）
- `timelimit`: 關卡時間限制，單位為毫秒
- `background`: 背景名稱，由 `background.json` 定義，詳見 [background.md](./background.md)，若為空字串則顯示預設背景
- `music`: 背景音樂名稱，由 `audio.json` 定義，詳見 [audio.md](./audio.md)，若為空字串則不播放背景音樂
- `vocab`: 單字庫設定，不可為空
  - `<單字庫序號>`: 單字庫序號（1-6）
  - `<單字庫權重>`: 單字庫權重，用於決定單字庫出現的機率，數字越大出現機率越高，總合不限定，但建議總合為 100
- `enemies`: 怪物設定
  - `mob`: 怪物名稱，由 `mob.json` 定義，詳見 [mob.md](./mob.md)
  - `moblevel`: 怪物強化等級，血量、攻擊傷害將乘上此數值，數值為 1 時不強化
  - `time`: 怪物出現時間，單位為毫秒
  - `interval`: 怪物出現間隔時間，單位為毫秒
  - `count`: 怪物數量

## 關卡設定檔範例

```json
  {
    "title": "Tutorial",
    "description": "This is a tutorial level.",
    "timelimit": 120000,
    "background": "volcanic",
    "music": "bgm1",
    "vocab": {
      "1": 100
    },
    "enemies": [
      {
        "mob": "Green",
        "moblevel": 1,
        "time": 120000,
        "interval": 30000,
        "count": 3
      },
      {
        "mob": "Bear",
        "moblevel": 1,
        "time": 120000,
        "interval": 30000,
        "count": 3
      }
    ]
  },
```

關卡設定檔範例中，設定了一個關卡，關卡標題為 `Tutorial`，描述為 `This is a tutorial level.`。  
時間限制為 120 秒，背景為 `volcanic`，背景音樂為 `bgm1`，單字庫為單字庫 1。  
怪物為 `Green` 和 `Bear`，怪物強化等級為 1，出現時間為 120 秒，出現間隔為 30 秒，數量為 3，分別在倒數 120 秒、90 秒、60 秒出現。
