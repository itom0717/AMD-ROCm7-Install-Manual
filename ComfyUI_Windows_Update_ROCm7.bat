@echo off
set BasePath=C:\ComfyUI_ROCm7

cd /d "%BasePath%"

rem UTF-8 ���f�t�H���g�ɂ���
set PYTHONUTF8=1

rem Python���z�����A�N�e�B�x�[�g
call venv\Scripts\activate

python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-dgpu/  "rocm[libraries,devel]" --upgrade pip
python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-dgpu/ --pre torch torchaudio torchvision --upgrade pip


