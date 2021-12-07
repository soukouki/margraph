
array = [1, 5, 2, 9, 4, 0]

# 昇順
for i in range(1, len(array)):
  print(array)
  value = array[i]
  # array[0..i]のすでにソートされた場所から、挿入場所を探す
  while i > 0 and array[i-1] > value:
    # 挿入場所を確保するため、アイテムをずらしていく
    array[i] = array[i-1]
    i -= 1
  array[i] = value

print(array)
exit()

# 降順
for i in range(1, len(array)):
  value = array[i]
  while i > 0 and array[i-1] < value: # この部分を変更
    array[i] = array[i-1]
    i -= 1
  array[i] = value

print(array)
