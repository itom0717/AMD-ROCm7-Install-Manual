@echo off

set BasePath=C:\ComfyUI_ROCm7

set ComfyUIPath=%BasePath%\ComfyUI
cd /d "%BasePath%"

rem UTF-8 ���f�t�H���g�ɂ���
set PYTHONUTF8=1

rem Python���z�����A�N�e�B�x�[�g
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
echo ComfyUI�N��
echo -------------------------------------
cd /d "%ComfyUIPath%"

rem �����������A�e���V������L��
set TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL=1

rem �ŏ��͒x����2��ڈȍ~�͏�����������
set PYTORCH_TUNABLEOP_ENABLED=1

rem GPU�f�o�C�X���w��
set CUDA_VISIBLE_DEVICES=1

rem �o�̓p�X(�C�ӂ̃p�X�ɕύX)
set OUTPUT_DIRECTORY=%USERPROFILE%\OneDrive\�摜\AI����\ComfyUI\00_Output

rem �N���I�v�V����
set COMMANDLINE_ARGS=--use-pytorch-cross-attention --normalvram --disable-xformers --fp16-unet --fp16-text-enc --bf16-vae 

rem �N��
python main.py %COMMANDLINE_ARGS% --output-directory "%OUTPUT_DIRECTORY%"

