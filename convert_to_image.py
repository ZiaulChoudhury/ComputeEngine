from PIL import Image

img = Image.new('RGB', size = (252, 252))

file1 = open("fpgaOut.txt", "r")
data = file1.readlines()

itr = 0
pixels = img.load()
for i in range(img.size[1]):
    for j in range(img.size[0]):
        pixels[j, i] = (3*int(data[itr]), 3*int(data[itr]), 3*int(data[itr]))
        itr += 1

img.convert('L')

img.save('resultOut.png')
