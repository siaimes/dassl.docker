FROM siaimes/pytorch1.10.0:v1.0.1

RUN apt-get update && apt-get install git -y

WORKDIR /

RUN git clone https://github.com/KaiyangZhou/Dassl.pytorch.git

WORKDIR /Dassl.pytorch

RUN pip install -r requirements.txt

RUN python setup.py develop
