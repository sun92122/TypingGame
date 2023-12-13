# 怪物

*StarBurst 及 Bird 具有其他機制，不在此文件規範*  
*如果有辦法常規化也不錯*

## 設定檔位置

`data/setting/mobs.json`

## 設定值

```json
[
  {
    "name": "<怪物名稱>",
    "HP": 100.0,
    "attack": {
      "damage": 10.0,
      "distance": 100,
      "duration": 5000
    },
    "velocity": 0.05,
    "scale": 0.08,
    "pictures": {
      "idle": [
        {
          "duration": 1000,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        },
      ],
      "moving": [
        {
          "duration": 1000,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        },
      ],
      "attacking": [
        {
          "duration": 1000,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        },
      ],
      "dead": [
        {
          "duration": 1000,
          "path": "<圖片路徑>",
          "x": 0,
          "y": 0
        },
      ]
    }
  }
]
```

- `name` *字串*： 怪物名稱，用於識別怪物，不可重複
- `HP` *浮點數*： 怪物血量
- `attack`： 怪物攻擊設定
  - `damage` *浮點數*： 怪物攻擊傷害
  - `distance` *整數*： 怪物攻擊距離 （像素）
  - `duration` *整數*： 怪物攻擊間隔時間 （毫秒）
- `velocity` *浮點數*： 怪物移動速度 （像素/(秒/60)）
- `scale` *浮點數*： 怪物大小比例，長寬皆為原圖大小乘上此比例
- `pictures`： 怪物圖片設定
  - `idle`： 怪物待機圖片設定
  - `moving`： 怪物移動圖片設定
  - `attacking`： 怪物攻擊圖片設定
  - `dead`： 怪物死亡圖片設定
    - `duration` *整數*： 整數，圖片持續時間 （毫秒）
    - `path` *字串*： 圖片路徑，路徑起始於 `data` 資料夾
    - `x` *整數*： 圖片 X 偏移 （像素）
    - `y` *整數*： 圖片 Y 偏移 （像素）

## 加入怪物至關卡

詳見 [level.md](./level.md)。

## 設定值範例

```json
  {
    "name": "Bear",
    "HP": 100,
    "attack": {
      "damage": 10,
      "distance": 100,
      "duration": 5000
    },
    "velocity": 0.06,
    "scale": 0.12,
    "pictures": {
      "idle": [
        {
          "duration": 1000000,
          "path": "images/mobs/bear/bear1.svg",
          "x": 0,
          "y": 0
        }
      ],
      "moving": [
        {
          "duration": 150,
          "path": "images/mobs/bear/bear1.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear2.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear3.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear4.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear5.svg",
          "x": 0,
          "y": 0
        }
      ],
      "attacking": [
        {
          "duration": 150,
          "path": "images/mobs/bear/bear been attacked1.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear been attacked2.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear been attacked3.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear been attacked4.svg",
          "x": 0,
          "y": 0
        },
        {
          "duration": 150,
          "path": "images/mobs/bear/bear been attacked5.svg",
          "x": 0,
          "y": 0
        }
      ],
      "dead": [
        {
          "duration": 100000,
          "path": "images/mobs/bear/bear been attacked5.svg",
          "x": 0,
          "y": 0
        }
      ]
    }
  }
```

怪物設定值範例中定義了一隻名為 `Bear` 的怪物。  
基礎血量為 100，基礎攻擊傷害為 10，依照關卡強化等級會乘上一個倍率（詳見 [level.md](./level.md)）。  
攻擊距離為 100 像素，攻擊間隔時間為 5 秒，移動速度為 0.06 像素/(秒/60)，長寬為原圖的 0.12 倍。  
步行時會依序播放移動圖片，攻擊時會依序播放攻擊圖片，死亡時會播放死亡圖片，其餘時候播放待機圖片。
