# EmacsInit
備份 emacs 設定檔

# 索引
- [檔案](#檔案)
- [使用 Emacs 設定檔](#使用-emacs-設定檔)
  - [在 Linux 和 Mac 上](#在-linux-和-mac-上)
- [安裝](#安裝)
  - [使用安裝腳本](#使用安裝腳本)
    - [修改腳本](#修改腳本)
    - [使用參數](#使用參數)
  - [使用 Makefile](#使用-makefile)
- [快捷鍵](#快捷鍵)
- [套件包](#套件包)

# 檔案
- **.emacs**      : [emacs](https://www.gnu.org/software/emacs/index.html) 的設定
- **install.sh**  : **.emacs** 的安裝腳本
- **makefile**    : 處理 **.emacs** 的 makefile 

# 使用 Emacs 設定檔
開啟 emacs 並輸入 **C-h r** 會打開 emacs 文檔

接著輸入 **g Init File** 並按下 **Enter** 鍵, 會開啟如何放置 emacs 設定檔的說明文件

下面我會講我將 emacs 設定檔放在哪作為參考

## 在 Linux 和 Mac 上
我將 ".emacs" 放在 "$HOME/"

這是 emacs 設定檔的預設位置

# 安裝
## 使用安裝腳本
這個腳本是用 **bash** script 寫的，所以任何支援 bash script 的 shell 都可以使用

下面會講解如何使用這個腳本

- 首先在 shell 輸入 ```chmod u+x install.sh``` 來讓安裝腳本可以被執行
- 視情況修改腳本中的變數
- 在 shell 輸入 ```./install.sh``` 來安裝 **.emacs** 檔

有兩種方式可以設定腳本的變數

### 修改腳本
- **targetDir**

  這是 **.emacs** 的安裝資料夾
- **initTargetName**

  這是 **.emacs** 安裝後的檔案名稱

### 使用參數
腳本有三個參數，如果沒有給定的話，會使用預設值

1. initSourceName : **.emacs** 原始檔的名稱
2. targetDir      : **.emacs** 的安裝資料夾
3. initTargetName : **.emacs** 安裝後的檔案名稱

## 使用 Makefile
makefile 是為那些想用 **make** 來處理的人寫的

一個原因是因為這樣可以方便我更新原始檔

目前 makefile 提供下列選項
- 預設      : 更新原始檔

  當 **make** 沒有給參數時會做這件事
- install   : 安裝 **.emacs**

  實際上這是使用安裝腳本，因此在使用前要確認安裝腳本可以被執行
- uninstall : 解除安裝 **.emacs**

若要改變 **.emacs** 的安裝路徑與檔案名稱，請直接修改 makefile 中的變數

這些變數和安裝腳本的變數是一樣的

# 快捷鍵
- C-c a : 開啟 org agenda dispatcher

# 套件包
- evil : Extensable VI Layer, 讓 emacs 可以使用 vi 的按鍵配置與 mode
