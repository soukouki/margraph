
a = [1, 5, 2, 9, 4, 0]

n = len(a)

# 昇順
for i in range(1, n):
  print(a)
  value = a[i]
  # a[0..i]のすでにソートされた場所から、挿入場所を探す
  while i > 0 and a[i-1] > value:
    # 挿入場所を確保するため、アイテムをずらしていく
    a[i] = a[i-1]
    i -= 1
  a[i] = value

print(a)

# 降順
for i in range(1, n):
  value = a[i]
  while i > 0 and a[i-1] < value: # この部分を変更
    a[i] = a[i-1]
    i -= 1
  a[i] = value

print(a)
