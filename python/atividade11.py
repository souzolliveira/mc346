import numpy as np

global array_global
array_global = np.array([])
array_input = np.array([[1, 2, 3], [-1, 1, 2], [-2, 4, 8], [7, 8, 10]])


def normalizacao(array):
    global array_global
    if(array[0] < 0):
        soma = np.absolute(array).sum(axis=0)
        array = array / soma
    array_global = np.concatenate((array_global, array), axis=0)


def main(array_input):
    global array_global
    i, j = np.shape(array_input)
    print(array_input)
    np.apply_along_axis(normalizacao, 1, array_input)
    array_final = np.array(array_global).reshape((i, j))
    print(array_final)


main(array_input)
