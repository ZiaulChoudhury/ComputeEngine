import numpy as np
import math
from FixedPoint import FXfamily, FXnum

def create16BitWeight(num):
    prec = FXfamily(n_bits=6, n_intbits=10)
    num = FXnum(num, prec)
    binary = num.toBinaryString(1)
    binary = binary.replace('.', '')
    binary = binary[0:8] + binary[8:16]
    a = np.fromstring(binary, 'u1') - ord('0')
    b = np.packbits(a.reshape(-1, 2, 8)[:, ::-1]).view(np.uint16)
    return b

def create32BitInput(num):
    prec = FXfamily(n_bits=16, n_intbits=16)
    num = FXnum(num, prec)
    binary = num.toBinaryString(1)
    binary = binary.replace('.', '')
    binary = binary[0:8] + binary[8:16] + binary[16:24] + binary[24:32]
    a = np.fromstring(binary, 'u1') - ord('0')
    b = np.packbits(a.reshape(-1, 4, 8)[:, ::-1]).view(np.uint32)
    return b

x, y = np.meshgrid(np.linspace(-1,1,5), np.linspace(-1,1,5))
d = np.sqrt(x*x+y*y)
sigma, mu = 1.0, 0.0
g = np.exp(-( (d-mu)**2 / ( 2.0 * sigma**2 ) ) )
weights = g.flatten().tolist()

#for w in weights:
#    print(w)
#'''
W16 = weights[0:16]
W8  = weights[16:24]
W1  = weights[24]

for i in range(0,2):
    for w in W16:
        print(create16BitWeight(w))

for i in range(0,2):
    for w in W8:
        print(create16BitWeight(w))


for i in range(0,2):
        print(create16BitWeight(W1))
#'''
