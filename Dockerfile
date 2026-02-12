# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.7.1-base

WORKDIR /comfyui

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git config --global --add safe.directory /comfyui && \
    git checkout master && \
    git pull

# Install updated dependencies required for Qwen/Anima
RUN pip install --upgrade transformers sentencepiece protobuf
# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# (no custom registry nodes were provided in the workflow)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/diffusion_models/anima-preview.safetensors --relative-path models/diffusion_models --filename anima-preview.safetensors
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/text_encoders/qwen_3_06b_base.safetensors --relative-path models/text_encoders --filename qwen_3_06b_base.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
