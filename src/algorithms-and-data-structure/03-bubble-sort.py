
a = [1, 5, 2, 9, 4, 0]

n = len(a)

for i in range(0, n-1):
  for j in range(n-1, i,-1):
    print(i, j, a)
    if a[j] < a[j-1]:
      a[j], a[j-1] = a[j-1], a[j]

print(a)
