@echo off

set BasePath=C:\ComfyUI_ROCm7

set ComfyUIPath=%BasePath%\ComfyUI
cd /d "%BasePath%"

rem UTF-8 をデフォルトにする
set PYTHONUTF8=1

rem Python仮想環境をアクティベート
call venv\Scripts\activate

echo ----------------------------------------------
echo ComfyUI Update
echo ----------------------------------------------
cd /d "%ComfyUIPath%"

set FILE_DATE1=0
set FILE_DATE2=0
for %%A in (requirements.txt) do set FILE_DATE1=%%~tA
git pull
for %%A in (requirements.txt) do set FILE_DATE2=%%~tA
if "%FILE_DATE1%" neq "%FILE_DATE2%" (
	pip install -r requirements.txt
)
echo -

echo ----------------------------------------------
echo ComfyUI Custom Nodes Update
echo ----------------------------------------------
cd /d "%ComfyUIPath%\custom_nodes"

for /D %%A in (*) do (
	pushd %%A

	set FILE_DATE1=0
	set FILE_DATE2=0

	if exist ".git" (
		echo ----------------------
		echo %%A
		echo ----------------------

		if exist "requirements.txt" (
			for %%A in (requirements.txt) do set FILE_DATE1=%%~tA
		)

		git pull

		if exist "requirements.txt" (
			for %%A in (requirements.txt) do set FILE_DATE2=%%~tA
			if "%FILE_DATE1%" neq "%FILE_DATE2%" (
				pip install -r requirements.txt
			)
		)

		echo -
	)

	popd
)


echo -------------------------------------
echo ComfyUI起動
echo -------------------------------------
cd /d "%ComfyUIPath%"

rem メモリ効率アテンションを有効
set TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL=1

rem 最初は遅いが2回目以降は処理を高速化
set PYTORCH_TUNABLEOP_ENABLED=1

rem GPUデバイスを指定
set CUDA_VISIBLE_DEVICES=1

rem 出力パス(任意のパスに変更)
set OUTPUT_DIRECTORY=%USERPROFILE%\OneDrive\画像\AI生成\ComfyUI\00_Output

rem 起動オプション
set COMMANDLINE_ARGS=--use-pytorch-cross-attention --normalvram --disable-xformers --fp16-unet --fp16-text-enc --bf16-vae 

rem 起動
python main.py %COMMANDLINE_ARGS% --output-directory "%OUTPUT_DIRECTORY%"

