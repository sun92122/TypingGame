# 音效與音樂

## 加入至遊戲庫

在遊戲中加入音效與音樂，需要先將音效與音樂加入至遊戲庫中，才能在遊戲中使用。

### 位置

音效與音樂的位置在 `data/audio` 資料夾中。

### 設定檔

音效與音樂的設定檔為 `data/setting/audios.json`。

### 設定值

路徑起始於 `data` 資料夾。

```json
{
  "musics": [
    {
      "name": "<音樂名稱>",
      "path": "audio/music/<音樂檔案名稱>"
    }
  ],
  "sounds": [
    {
      "name": "<音效名稱>",
      "path": "audio/sound/<音效檔案名稱>"
    }
  ]
}
```

## 使用

所有音效與音樂的使用，都是透過 `AudioManager` 進行。  
由**全域變數 `audio`** 取得 `AudioManager` 實體。

### 播放音效

```java
// 播放音效，若音效正在播放中，則同時播放多個音效
audio.playSound("<音效名稱>");
// 播放音效，若音效正在播放中，則不播放，與 audio.playSoundIfNotPlaying("<音效名稱>") 相同
audio.playSound("<音效名稱>", 1);
// 播放音效，若音效正在播放中，則停止目前播放的音效，播放新的音效，與 audio.playSoundOnly("<音效名稱>") 相同
audio.playSound("<音效名稱>", 2);

// 播放音效，若音效正在播放中，則不播放
audio.playSoundIfNotPlaying("<音效名稱>");
// 播放音效，若音效正在播放中，則停止目前播放的音效，播放新的音效
audio.playSoundOnly("<音效名稱>");
```

### 播放音樂

```java
// 播放音樂，若音樂正在播放中，則不播放
audio.playMusic("<音樂名稱>");
```

### 暫停音樂

```java
// 暫停指定音樂
audio.pauseMusic("<音樂名稱>");

// 暫停所有音樂
audio.pauseAllMusic();
```
