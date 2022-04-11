
a = [1, 5, 2, 9, 4, 0]

n = len(a)

for i in range(0, n-1):
  minj = i
  for j in range(i, n):
    print(i, j, minj, a)
    if a[j] < a[minj]:
      minj = j
  if i != minj:
    a[i], a[minj] = a[minj], a[i]

print(a)
