FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel AS builder

RUN apt-key del 7fa2af80 && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb && sudo dpkg -i cuda-keyring_1.0-1_all.deb

WORKDIR /

RUN apt-get update && apt-get install -y curl zip

RUN curl https://dl.freefontsfamily.com/download/Times-New-Roman-Font/ -o Times-New-roman.zip

RUN unzip Times-New-roman.zip

RUN mkdir Times-New-Roman

RUN cp "Times New Roman"/* "Times-New-Roman/"

FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

RUN apt-key del 7fa2af80 && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb && sudo dpkg -i cuda-keyring_1.0-1_all.deb

RUN conda install -y faiss-gpu scikit-learn pandas flake8 yapf isort yacs gdown future -c conda-forge

RUN pip install opencv-python tb-nightly matplotlib pyro-ppl logger_tt tabulate

RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip git

COPY --from=builder /Times-New-Roman/* /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/

WORKDIR /

RUN git clone https://github.com/KaiyangZhou/Dassl.pytorch.git

WORKDIR /Dassl.pytorch

RUN pip install -r requirements.txt

RUN python setup.py develop
