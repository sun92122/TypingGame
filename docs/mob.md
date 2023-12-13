# 怪物

*StarBurst 及 Bird 具有其他機制，不在此文件規範*

## 設定檔位置

`data/setting/mobs.json`

## 設定值

```json
[
  {
    "name": "<怪物名稱>",
    "HP": <怪物血量>,
    "attack": {
      "damage": <怪物攻擊傷害>,
      "distance": <怪物攻擊距離>,
      "duration": <怪物攻擊間隔時間>
    },
    "velocity": <怪物移動速度>,
    "scale": <怪物大小比例>,
    "pictures": {
      "idle": [
        {
          "duration": <圖片持續時間>,
          "path": "<圖片路徑>",
          "x": <圖片 X 偏移>,
          "y": <圖片 Y 偏移>
        },
        ...
      ],
      "moving": [
        {
          "duration": <圖片持續時間>,
          "path": "<圖片路徑>",
          "x": <圖片 X 偏移>,
          "y": <圖片 Y 偏移>
        },
        ...
      ],
      "attacking": [
        {
          "duration": <圖片持續時間>,
          "path": "<圖片路徑>",
          "x": <圖片 X 偏移>,
          "y": <圖片 Y 偏移>
        },
        ...
      ],
      "dead": [
        {
          "duration": <圖片持續時間>,
          "path": "<圖片路徑>",
          "x": <圖片 X 偏移>,
          "y": <圖片 Y 偏移>
        },
        ...
      ]
    }
  }
]
```

- `name`: 怪物名稱，用於識別怪物，不可重複
- `HP`: 怪物血量
- `attack`: 怪物攻擊設定
  - `damage`: 怪物攻擊傷害
  - `distance`: 怪物攻擊距離 (像素)
  - `duration`: 怪物攻擊間隔時間 (毫秒)
- `velocity`: 怪物移動速度 (像素/(秒/60))
- `scale`: 怪物大小比例，長寬皆為原圖大小乘上此比例
- `pictures`: 怪物圖片設定
  - `idle`: 怪物待機圖片設定
  - `moving`: 怪物移動圖片設定
  - `attacking`: 怪物攻擊圖片設定
  - `dead`: 怪物死亡圖片設定
    - `duration`: 圖片持續時間 (毫秒)
    - `path`: 圖片路徑，路徑起始於 `data` 資料夾
    - `x`: 圖片 X 偏移 (像素)
    - `y`: 圖片 Y 偏移 (像素)

## 使用

詳見 [關卡](./level.md) 文件。