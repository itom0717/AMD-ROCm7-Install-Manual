# Windows + ROCm 7.x + ComfyUI環境を構築作成
* ROCm Ver.7.x用

## PC環境
| 項目 | スペック |
|:----|:---|
| OS  | Windows 11 Pro |
| CPU | AMD Ryzen9 7950X3D |
| RAM | 64GB |
| GPU | AMD Radeon RX 7900 XTX |
* 上記の環境で動作確認を行っています

## 導入手順
1. Python 3.13.7をダウンロード・インストール

   1. ダウンロード先
      * https://www.python.org/downloads/windows/

   2. インストール時にAdd python.exe to PATHにチェックを入れる
   
2. Gitのダウンロード・インストール

   1. ダウンロード先
      * https://git-scm.com/

3. インストール先のフォルダ作成
   * C:\ComfyUI_ROCm7 にインストールする場合です。
   * 別のフォルダに入れたい場合は読み替えてください
  
   1. コマンドプロンプトを実行
      * 「ファイル名を指定して実行」にて、以下のコマンドを実行
      ```
      cmd
      ```

   2. フォルダを作成
      ```
      mkdir C:\ComfyUI_ROCm7
      ```

   3. カレントディレクトリを移動
      ```
      cd /d C:\ComfyUI_ROCm7
      ```

4. Python仮想環境を作成＆アクアクティベート
      * UTF-8 をデフォルトにする
      ```
      set PYTHONUTF8=1
      ```
      ```
      py -3.13 -m venv venv
      ```
      ```
      call venv\Scripts\activate
      ```

5. pipをアップデート

      ```
      python -m pip install --upgrade pip
      ```

6. AMD ROCm7.xとPyTorchを導入
   * 以下のURLの説明から、自分のグラボに合ったパッケージをインストール
      https://github.com/ROCm/TheRock/blob/main/RELEASES.md
   * ナイトリービルドです

   * AMD Radeon RX 7900 XTXで説明します
   1. ROCm Python packagesをインストール
      ```
      python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-all/ "rocm[libraries,devel]"
      ```
   2. PyTorch Python packagesをインストール
      ```
      python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-all/ --pre torch torchaudio torchvision
      ```

7. ComfyUIをインストール
   1. 本体をインストール
      ```
      git clone https://github.com/comfyanonymous/ComfyUI.git
      ```
   
   2. ComfyUIの必要なパッケージをインストール
      ```
      cd ComfyUI
      ```
      ```
      pip install -r requirements.txt
      ```

   3. ComfyUI-Managerをインストール
      ```
      cd custom_nodes
      ```
      ```
      git clone https://github.com/ltdrdata/ComfyUI-Manager.git
      ```

   4. 必要なカスタムノードインストール（任意です）
      ```
      git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
      git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git
      git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
      git clone https://github.com/WASasquatch/was-node-suite-comfyui.git
      git clone https://github.com/AlekPet/ComfyUI_Custom_Nodes_AlekPet.git
      git clone https://github.com/kijai/ComfyUI-KJNodes.git
      git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git
      git clone https://github.com/rgthree/rgthree-comfy.git
      git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale
      git clone https://github.com/alexopus/ComfyUI-Image-Saver.git
      git clone https://github.com/tkoenig89/ComfyUI_Load_Image_With_Metadata.git
      git clone https://github.com/shiimizu/ComfyUI_smZNodes.git
      git clone https://github.com/jags111/efficiency-nodes-comfyui.git
      ```

   5. カレントフォルダを移動する
      ```
      cd /d C:\ComfyUI_ROCm7
      ```

   6. numpyのダウングレード
      ```
      pip install "numpy<2.3"
      ```

   7. コマンドプロンプトを閉じる
      ```
      exit
      ```

   8. ComfyUI起動（バッチファイルを作成したほうが良いです）
      1. コマンドプロンプトを実行
      ```
      cmd
      ```

      2. カレントディレクトリを移動
      ```
      cd /d C:\ComfyUI_ROCm7
      ```

      3. Python仮想環境をアクアクティベート
      ```
      call venv\Scripts\activate
      ```

      4. 環境変数を設定

      * メモリ効率アテンションを有効
      ```
      set TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL=1
      ```
      * GPU内蔵System DMAを無効
      ```
      set HSA_ENABLE_SDMA=0
      ```
      * GPUデバイスを指定
      * 複数のGPU（iGPU含む）は処理するGPUを指定する
      * 数字は環境によって異なるため 各自指定してください（0～）
      ```
      set CUDA_VISIBLE_DEVICES=1
      ```

      * ComfyUI起動オプション
      * 任意で指定してください
      ```
      set COMMANDLINE_ARGS=--use-pytorch-cross-attention --normalvram
      ```

      * ComfyUI起動
      ```
      cd ComfyUI
      ```
      ```
      python main.py %COMMANDLINE_ARGS% 
      ```
      * 「 To see the GUI go to: http://127.0.0.1:8188 」と表示されたら、ブラウザで `http://127.0.0.1:8188` を開いて起動確認
      * 終了する場合はCTRL+Cで終了


   8. おまけ
      1. AMD ROCm7.xとPyTorchをアップデート
      ```
      cd /d C:\ComfyUI_ROCm7
      call venv\Scripts\activate
      python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-dgpu/  "rocm[libraries,devel]" --upgrade pip
      python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-dgpu/ --pre torch torchaudio torchvision --upgrade pip
      ```

      2. 自分の環境用のバッチファイルを置いておきます
         1. インストール用: ComfyUI_Windows_Install_rocm7.bat
         2. ComfyUI起動用: ComfyUI_Windows_ROCm7.bat
         3. ROCm7.xとPyTorchをアップデート用: ComfyUI_Windows_Update_ROCm7.bat

            * パス等は書き換えてください
            * rocmとPyTorchのパッケージは自分のGPUのものに置き換えてください（バッチファイルは 7900 XTX用です）
            * ComfyUI起動時にComfyUI本体とすべてのカスタムノードの更新を行います


## Author
[itom0717](https://github.com/itom0717)
