@echo off
set BasePath=C:\ComfyUI_ROCm7

echo ----------------------------------------------
echo Rocm 7.xx �C���X�g�[������
echo �C���X�g�[���� �G %BasePath%
echo ----------------------------------------------
pause
set ComfyUIPath=%BasePath%\ComfyUI
mkdir "%BasePath%"
cd /d "%BasePath%"

rem UTF-8 ���f�t�H���g�ɂ���
set PYTHONUTF8=1

rem ���z�����쐬
echo ----------------------------------------------
echo Python���z�����쐬
echo ----------------------------------------------
py -3.13 -m venv venv

echo ----------------------------------------------
echo Python���z�����A�N�e�B�x�[�g
echo ----------------------------------------------
call venv\Scripts\activate

echo ----------------------------------------------
echo pip���A�b�v�f�[�g
echo ----------------------------------------------
python -m pip install --upgrade pip

echo ----------------------------------------------
echo ROCm Python packages���C���X�g�[��
echo ----------------------------------------------
python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-dgpu/  "rocm[libraries,devel]" 

echo ----------------------------------------------
echo PyTorch Python packages���C���X�g�[��
echo ----------------------------------------------
python -m pip install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-dgpu/ --pre torch torchaudio torchvision



echo ----------------------------------------------
echo ComfyUI���C���X�g�[��
echo ----------------------------------------------
git clone https://github.com/comfyanonymous/ComfyUI.git

echo ----------------------------------------------
echo ComfyUI�̕K�v�ȃp�b�P�[�W���C���X�g�[��
echo ----------------------------------------------
cd /d "%ComfyUIPath%"
pip install -r requirements.txt

echo ----------------------------------------------
echo ONNX�����^�C�����C���X�g�[������
echo ----------------------------------------------
pip install onnxruntime

cd /d "%ComfyUIPath%\custom_nodes"
echo ----------------------------------------------
echo ComfyUI-Manager���C���X�g�[��
echo ----------------------------------------------
git clone https://github.com/ltdrdata/ComfyUI-Manager.git

echo ----------------------------------------------
echo �K�v�ȃJ�X�^���m�[�h�C���X�g�[��
echo ----------------------------------------------
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
git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git
git clone https://github.com/chrisgoringe/cg-controller.git
git clone https://github.com/asagi4/comfyui-prompt-control.git


echo ----------------------------------------------
echo �e�J�X�^���m�[�h�̕K�v�ȃp�b�P�[�W���C���X�g�[��
echo ----------------------------------------------
for /D %%A in (*) do (
	pushd %%A
	if exist "requirements.txt" (
		pip install -r requirements.txt
	)
	popd
)



cd /d "%BasePath%"

echo ----------------------------------------------
echo numpy�̃_�E���O���[�h
echo ----------------------------------------------
pip install "numpy<2.3"

echo ----------------------------------------------
echo FFmpeg
echo ----------------------------------------------
rem winget install --id=Gyan.FFmpeg -e


echo ----------------------------------------------
echo �C���X�g�[���I�����܂���
echo ----------------------------------------------

