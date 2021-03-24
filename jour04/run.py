import hashlib

def calculMd5(mot, nbZeros):
    """
    Calcule la partie manquante de mot ayant un hash md5 commencant
    par un nombre donné de 0.

    :param mot string: le début du mot
    :param nbZeros int: le nombre de zéro du hash md5
    """
    i = 1
    find = False
    md = None
    while not find:
        md = hashlib.md5((mot + str(i)).encode("utf-8"))
        if md.hexdigest()[0:nbZeros] == "0" * nbZeros:
            find = True;
        else:
            i += 1
    return i

myInput = "iwrupvqb"
print("Traitement de la partie 1…")
print(calculMd5(myInput, 5))
print("Traitement de la partie 2…")
print(calculMd5(myInput, 6))
