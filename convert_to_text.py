from PIL import Image

im = Image.open("dark-knight.jpg", "r")
im = im.convert('L')
im.save('result.png')
width, height = im.size
pix_val = list(im.getdata())

pix_val_flat = [str(x)+"\n" for x in pix_val]

file1 = open("data.txt", "w")
file1.write(str(width) + " ")
file1.write(str(height) + "\n")
file1.writelines(pix_val_flat)
file1.close()
