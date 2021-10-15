def substring (string1, string2):
    string1 = string1[::-1]
    string2 = string2[::-1]
    string2 = string2[string2.find(string1[0]):]
    substring = ''
    r = min(len(string1), len(string2))
    for i in range(r):
        if (string1[i] == string2[i]): substring += string1[i]
        else:
            if (i == r - 1): substring = ''
            else: substring = string2[i]
    return len(substring)

def main ():
    string1 = input('Type the first string: ')
    string2 = input('Type the second string: ')
    print(substring(string1, string2))

main()

    