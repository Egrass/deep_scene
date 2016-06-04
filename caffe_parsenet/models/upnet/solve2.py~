from __future__ import division
import numpy as np
#import matplotlib.pyplot as plt
#import Image

# Make sure that caffe is on the python path:
caffe_root = '/mnt/shared/deepscene/code/caffe_parsenet/'  # this file is expected to be in {caffe_root}/examples
import sys
sys.path.insert(0, caffe_root + 'python')

import caffe
 
# base net -- follow the editing model parameters example to make
# a fully convolutional VGG16 net.
base_weights = 'FCN_FULL_Refinement_iter_770000.caffemodel'
 
# init
caffe.set_mode_gpu()
caffe.set_device(3)
 
solver = caffe.SGDSolver('solverFCN32s_1024.prototxt')
 
# copy base weights for fine-tuning
solver.net.copy_from(base_weights)
 
# solve straight through -- a better approach is to define a solving loop to
# 1. take SGD steps
# 2. score the model by the test net `solver.test_nets[0]`
# 3. repeat until satisfied
solver.step(300000)
