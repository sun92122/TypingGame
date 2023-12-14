# 背景

## 設定檔位置

`data/setting/backgrounds.json`

## 設定值

```json
{
  "pictures": [
    {
      "name": "<背景物件名稱>",
      "path": "<圖片路徑>",
    }
  ],
  "maps": [
    {
      "name": "<地圖名稱>",
      "pictures": [
        "<背景物件名稱>"
      ],
      "behind": [
        {
          "mode": "<模式>",
          "picture": "<背景物件名稱>",
          "width": 300,
          "height": 20,
          "startx": 0,
          "starty": 475,
          "endx": 2560,
          "endy": 475,
          "velocity": 0.1,
          "interval": 300,
          "count": 3
        }
      ],
      "infront": [
      ]
    }
  ]
}
```

## 背景物件註冊

- `name` *字串*： 背景物件名稱，用於識別背景物件，不可重複
- `path` *字串*： 背景物件圖片路徑

## 地圖註冊

- `name` *字串*： 地圖名稱，用於識別地圖，不可重複
- `pictures` *字串陣列*： 宣告地圖中使用的背景物件，需與[背景物件註冊](#背景物件註冊)的 `name` 相同
- `behind` *物件設定陣列*： 宣告地圖中的背景物件，會在主角與怪物之後顯示
- `infront` *物件設定陣列*： 宣告地圖中的背景物件，會在主角與怪物之前顯示

### 物件設定

- `mode` *字串*： 物件移動模式
  - `repeat`： 重複繪製物件以填滿 `startx` 至 `endx`，`starty` 至 `endy` 的區域
  - `once`： 繪製物件一次，位於 `startx` 、 `starty` 的位置，背景移動時以 `velocity` 速度移動
  - `interval`： 繪製物件 `count` 次，每次位於 `startx` 、 `starty` 的位置，x 座標每次增加 `interval` ，背景移動時以 `velocity` 速度移動
- `picture` *字串*： 物件名稱，需與[背景物件註冊](#背景物件註冊)的 `name` 相同
- `width` *整數*： 物件寬度
- `height` *整數*： 物件高度
- `startx` *整數*： 物件起始 x 座標
- `starty` *整數*： 物件起始 y 座標
- `endx` *整數*： 物件結束 x 座標
- `endy` *整數*： 物件結束 y 座標
- `velocity` *浮點數*： 物件移動速度（像素/(秒/60)）
- `interval` *整數*： 物件間隔時間（毫秒）
- `count` *整數*： 物件繪製次數

| 模式 | 必須參數 | 備註 |
| --- | --- | --- |
| `repeat` | `picture`、`width`、`height`、`startx`、`starty`、`endx`、`endy` |  |
| `once` | `picture`、`width`、`height`、`startx`、`starty`、`velocity` |  |
| `interval` | `picture`、`width`、`height`、`startx`、`starty`、`velocity`、`interval`、`count` |  |

完全在畫面外的物件不會被繪製。  
背景物件座標系與畫面座標系相同，原點在畫面左上角。  
物件設定的長寬不需與圖片長寬相同，會依照設定的長寬縮放圖片。  
不同地圖可以使用相同的背景物件。
