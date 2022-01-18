FROM siaimes/pytorch1.9.0:v1.4.7

RUN apt-get update && apt-get install git -y

WORKDIR /

RUN git clone https://github.com/KaiyangZhou/Dassl.pytorch.git

WORKDIR /Dassl.pytorch

RUN pip install -r requirements.txt

RUN python setup.py develop
