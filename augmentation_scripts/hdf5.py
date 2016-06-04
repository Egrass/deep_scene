#!/usr/bin/env python
import h5py
import numpy as np
import os

for i in range(1,20001):
	filename = ("aug_deformed_v31_file" + str(i) + ".h5");
	f4 = h5py.File(filename, "r");
	f4fertig = h5py.File("/home/oliveira/caffe-future/examples/FCN2_Claas_Augm/data" + filename, "w");
	data = f4['data'];
	data = np.expand_dims(data, axis=0);
	label = f4['label'];
	label = np.expand_dims(label, axis=0);
	label = np.transpose(label, [0,2,1]);
	data = np.transpose(data, [0,1,3,2]);
	f4fertig['data'] = data;
	f4fertig['label'] = label;
	f4.close();
	os.remove(filename);
	f4fertig.close();



