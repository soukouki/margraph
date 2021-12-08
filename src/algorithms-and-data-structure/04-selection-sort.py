
a = [1, 5, 2, 9, 4, 0]

n = len(a)

for i in range(0, n):
  minj = i
  for j in range(i+1, n):
    print(i, j, minj, a)
    if a[j] < a[minj]:
      minj = j
    a[i], a[minj] = a[minj], a[i]

print(a)
