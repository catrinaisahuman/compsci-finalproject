import numpy as np


def process(inputData):
	data = np.genfromtxt(inputData, skip_header=1, delimiter=',')
	data = [data]
	data = np.transpose(data)
	data = (data, 3)
	data = [data]
	return data
