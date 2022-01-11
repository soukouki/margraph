
def quick_sort(a, l, r):
  print(a, l, r)
  if(l<r):

    # partition
    x = a[r]
    i = l-1
    for j in range(l, r):
      if(a[j] <= x):
        i += 1
        [a[i], a[j]] = [a[j], a[i]]
    [a[i+1], a[r]] = [x, a[i+1]]
    q = i+1

    # sort
    quick_sort(a, l, q-1)
    quick_sort(a, q+1, r)

a = [1, 5, 2, 9, 4, 0]
quick_sort(a, 0, len(a)-1)
print(a)
