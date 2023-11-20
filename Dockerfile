# 使用 Java 基本映像
FROM openjdk:8

# 安裝依賴項
RUN apt-get update && apt-get install -y \
  unzip \
  wget \
  xorg \
  libxrender-dev \
  libxtst-dev \
  libgtk2.0-0

# 下載並安裝 Processing
RUN wget https://github.com/processing/processing4/releases/download/processing-1293-4.3/processing-4.3-linux-x64.tgz
RUN tar -zxvf processing-4.3-linux-x64.tgz
RUN mv processing-4.3 /opt/processing

# 設置環境變量
ENV PATH="/opt/processing:$PATH"

# 預設工作目錄
WORKDIR /usr/src/TypingGame

# 預設指令
CMD ["processing-java", "--sketch=/usr/src/TypingGame", "--run"]
