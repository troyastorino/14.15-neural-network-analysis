#!/usr/bin/python

import scipy.io

def convert_file(filename):
  with open(filename, 'r') as f:
    lines = f.readlines()

  classification = []
  features = []
  for line in lines:
    toks = line.split(' ')
    classification.append(int(toks[0]))
    feats = []
    for tok in toks[1:]:
      feats.append(float(tok.split(':')[1]))
    features.append(feats)

  scipy.io.savemat(filename.split('.')[0]+'.mat', mdict={'out': classification, 'in': features})

convert_file('svmguide1')
convert_file('svmguide1-t')