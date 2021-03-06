import hashlib

myInput = "iwrupvqb"
i = 1
find = False
md = None

print("Traitement de la partie 1…")

while not find:
    md = hashlib.md5((myInput + str(i)).encode("utf-8"))
    if md.hexdigest()[0:5] == "00000":
        find = True;
    else:
        i += 1

print(i)

print("Traitement de la partie 2…")

find = False
while not find:
    md = hashlib.md5((myInput + str(i)).encode("utf-8"))
    if md.hexdigest()[0:6] == "000000":
        find = True;
    else:
        i += 1

print(i)
