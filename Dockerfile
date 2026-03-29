# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:latest-base-cuda12.8.1

WORKDIR /comfyui

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git config --global --add safe.directory /comfyui && \
    git checkout master && \
    git pull

WORKDIR /comfyui/custom_nodes

RUN git clone https://github.com/AdamNizol/ComfyUI-Anima-Enhancer.git

WORKDIR /comfyui

# Install updated dependencies required for Qwen/Anima
RUN pip install --upgrade transformers sentencepiece protobuf comfy_aimdo
# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# (no custom registry nodes were provided in the workflow)

# download models/loras into comfyui
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/anima-masterpieces-nlmix2-e41.safetensors --relative-path models/loras --filename masterpiece.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/anima_preview_rdbt_finetuned_cfg_distilled_v0.12.safetensors --relative-path models/loras --filename distil.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/mixed_styles_anima_v1-e25.safetensors --relative-path models/loras --filename aistyles.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/skityomimas3.safetensors --relative-path models/loras --filename skityomimas3.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/hiu-lu5.safetensors --relative-path models/loras --filename hiu-lu5.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/fdnt3.safetensors --relative-path models/loras --filename fdnt3.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/fdnt6.safetensors --relative-path models/loras --filename fdnt6.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/vofc2.safetensors --relative-path models/loras --filename vofc2.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/voidfork.safetensors --relative-path models/loras --filename voidfork.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/lena5.safetensors --relative-path models/loras --filename lena5.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/lena.safetensors --relative-path models/loras --filename lena.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/frostia2.safetensors --relative-path models/loras --filename frostia2.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/violet2.safetensors --relative-path models/loras --filename violet2.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/sugita.safetensors --relative-path models/loras --filename sugita.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/meowbah3.safetensors --relative-path models/loras --filename meowbah3.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/meowbah4.safetensors --relative-path models/loras --filename meowbah4.safetensors
# RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/kuroe.safetensors --relative-path models/loras --filename kuroe.safetensors
RUN comfy model download --url https://huggingface.co/Bakanayatsu/noobai-loras/resolve/main/didac_fantasy.safetensors --relative-path models/loras --filename didac_fantasy.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/diffusion_models/anima-preview2.safetensors --relative-path models/diffusion_models --filename anima-preview2.safetensors
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/text_encoders/qwen_3_06b_base.safetensors --relative-path models/text_encoders --filename qwen_3_06b_base.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
