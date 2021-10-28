import numpy as np

array_input = np.ceil(np.random.rand(5, 5) * 100)


def main(array_input):

    print(array_input, '\n')
    print('Menor de cada coluna: ', np.amin(
        array_input, axis=0))
    print('Menor de cada linha: ', np.amin(
        array_input, axis=1))


main(array_input)
