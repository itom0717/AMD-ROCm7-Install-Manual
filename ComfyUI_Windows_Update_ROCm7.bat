@echo off
set BasePath=C:\ComfyUI_ROCm7

cd /d "%BasePath%"

rem UTF-8 ���f�t�H���g�ɂ���
set PYTHONUTF8=1

rem Python���z�����A�N�e�B�x�[�g
call venv\Scripts\activate

python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-all/ "rocm[libraries,devel]"
python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-all/ --pre torch torchaudio torchvision


