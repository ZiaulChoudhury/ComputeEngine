from PIL import Image

img = Image.new('RGB', size = (248, 248))

file1 = open("check.txt", "r")
data = file1.readlines()

itr = 0
pixels = img.load()
for i in range(img.size[1]):
    for j in range(img.size[0]):
        #pixels[j, i] = (3*int(data[itr]), 3*int(data[itr]), 3*int(data[itr]))
        pixels[j, i] = (int(data[itr]), int(data[itr]), int(data[itr]))
        itr += 1

img.convert('L')

img.save('resultOut.png')
