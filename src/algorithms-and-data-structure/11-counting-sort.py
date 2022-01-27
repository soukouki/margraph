
a = [1, 5, 2, 9, 4, 0, 2, 4, 0]
k = max(a)
counts = [0] * (k+1)
result = [0] * len(a)

for i in range(0, len(a)):
  counts[a[i]] += 1
for i in range(1, k+1):
  counts[i] = counts[i] + counts[i-1]
for i in range(len(a)-1, -1, -1):
  result[counts[a[i]]-1] = a[i]
  counts[a[i]] -= 1

print(result)
