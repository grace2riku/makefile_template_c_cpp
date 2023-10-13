# コンパイラの指定
CC := gcc
CXX := g++

# OSの判定
ifeq ($(OS),Windows_NT)
    EXT := .exe
else
    EXT :=
endif

# ターゲット名
C_TARGET := prog_c$(EXT)
CPP_TARGET := prog_cpp$(EXT)

# ソースファイルの取得
C_SRCS := $(wildcard *.c)
CPP_SRCS := $(wildcard *.cpp)

# ソースファイルからオブジェクトファイル名を導出
C_OBJS := $(C_SRCS:.c=.o)
CPP_OBJS := $(CPP_SRCS:.cpp=.o)

# コンパイルオプションとリンカオプション
CXXFLAGS := -std=c++14
CFLAGS   := # Cのコンパイルオプションを追加する場所
LDFLAGS  := # C・C++のリンカオプションを追加する場所

# 既定のターゲット (両方の実行ファイルを生成)
all: $(C_TARGET) $(CPP_TARGET)

# C言語の実行ファイルを生成
$(C_TARGET): $(C_OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

# C++の実行ファイルを生成
$(CPP_TARGET): $(CPP_OBJS)
	$(CXX) $^ -o $@ $(LDFLAGS)

# Cのソースファイルをオブジェクトファイルにコンパイル
%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)

# C++のソースファイルをオブジェクトファイルにコンパイル
%.o: %.cpp
	$(CXX) -c $< -o $@ $(CXXFLAGS)

# cleanターゲット
.PHONY: clean
clean:
ifeq ($(OS),Windows_NT)
	del /Q /F $(C_TARGET) $(CPP_TARGET) $(C_OBJS) $(CPP_OBJS)
else
	rm -f $(C_TARGET) $(CPP_TARGET) $(C_OBJS) $(CPP_OBJS)
endif
