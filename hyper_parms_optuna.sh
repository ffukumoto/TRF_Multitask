#! /bin/bash
DIR=./Data
valid_trainData=${DIR}/20news_train.xml
valid_testData=${DIR}/20news_train.xml

## hyper-params ##
epoch=1
batchSize=32
gpu=0
shuffle=yes
pretrained=0
multilabel=0
model=TRF-Delay-Multi
### 上の設定は本訓練でも同じにすること ##

## データベースの設定 ##
dbname=${model}
storagename="sqlite:///"${model}"_opt.db"


FP=RESULT_${model}
mkdir -p ${FP}

optuna create-study --study ${dbname} --storage ${storagename}

python program/opt_param.py -itrain ${valid_trainData}  -itest ${valid_testData} -m ${model}  \
-e ${epoch}  -b ${batchSize} -g ${gpu} --filepath ${FP} \
--shuffle ${shuffle} --pretrained ${pretrained} --multilabel ${multilabel} \
--dbname ${dbname} --storagename ${storagename}

mv ${model}_opt.db ${FP}