# 寵物

## 設定檔位置

`data/setting/pets.json`

## 寵物設定值

```json
[
  {
    "name": "<寵物名稱>",
    "scale": 0.1,
    "velocity": 2.0,
    "maxlevel": 5,
    "damage": [
      100,
      200,
      300,
      400,
      500
    ],
    "pictures": {
      "idle": [
        {
          "duration": 100000,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        }
      ],
      "moving": [
           {
          "duration": 100,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        }
      ],
      "attacking": [
        {
          "duration": 100,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        }
      ]
    }
  }
]
```

- `name` *字串*： 寵物名稱，用於識別寵物，不可重複
- `scale` *浮點數*： 寵物大小比例
- `velocity` *浮點數*： 寵物移動速度（像素/(秒/60)）
- `maxlevel` *整數*： 寵物最高等級
- `damage` *整數陣列*： 寵物各等級的攻擊力，陣列長度需等於 `maxlevel`
- `pictures` ；寵物各狀態的圖片
  - `idle`
  - `moving`
  - `attacking`
    - `duration` *整數*： 整數，圖片持續時間 （毫秒）
    - `path` *字串*： 圖片路徑，路徑起始於 `data` 資料夾
    - `x` *整數*： 圖片 X 偏移 （像素）
    - `y` *整數*： 圖片 Y 偏移 （像素）
