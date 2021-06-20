from PIL import Image

img = Image.new('RGB', size = (256, 256))

file1 = open("img.txt", "r")
data = file1.readlines()

itr = 0
pixels = img.load()
for i in range(img.size[1]):
    for j in range(img.size[0]):
        pixels[j, i] = (int(data[itr]), int(data[itr]), int(data[itr]))
        itr += 1

img.convert('L')

img.save('result.png')
