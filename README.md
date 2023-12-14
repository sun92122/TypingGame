# Typing Game

## 遊戲介紹

### 頁面介紹

### 玩法說明

### 商店

<!-- 
### 彩蛋

| 彩蛋 | 觸發位置 | 觸發條件 | 備註 |
| --- | --- | --- | --- |
 -->

## 原始碼說明

### 新增關卡、怪物、背景

詳見 [level.md](./docs/level.md)、[mob.md](./docs/mob.md)、[background.md](./docs/background.md)。

### 設定玩家角色、寵物

詳見 [character.md](./docs/character.md)、[pet.md](./docs/pet.md)。

### 設定音效

詳見 [audio.md](./docs/audio.md)。

### 執行與編譯

替換 `<path\to\rootFolder>` 為專案根目錄的路徑  
替換 `path\to\processing-java.exe` 為 processing-java.exe 的路徑
如 `.\processing-4.3\processing-java.exe --sketch="d:\GitHub\TypingGame\TypingGame" --run`

```bash

path\to\processing-java.exe --sketch="<path\to\rootFolder>\TypingGame" --run

path\to\processing-java.exe --sketch="<path\to\rootFolder>\TypingGame" --output="<path\to\rootFolder>\out" --force --export
```
