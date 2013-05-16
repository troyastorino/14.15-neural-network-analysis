#!/usr/bin/python

import scipy.io

def convert_file(filename):
  with open(filename, 'r') as f:
    lines = f.readlines()

  classification = []
  features = []
  for line in lines:
    toks = line.rstrip().split(' ')
    cls = int(toks[0])
    if cls == -1:
        cls = 0
    classification.append(cls)
    feats = []
    for tok in toks[1:]:
      feats.append(float(tok.split(':')[1]))
    features.append(feats)

  scipy.io.savemat(filename.split('.')[0]+'.mat', mdict={'out': classification, 'in': features})


for f in ['svmguide1', 'svmguide1-t', 'splice', 'splice-t']:
    convert_file(f)
