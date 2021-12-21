
def merge_sort(a, l, r):
  if(r - l == 1):
    return [a[l]]
  else:
    m = (l + r) // 2
    a_l = merge_sort(a, l, m)
    a_r = merge_sort(a, m, r)
    result = []
    for i in range(0, r-l):
      print(a_l, a_r, result)
      if len(a_l) > 0 and (len(a_r) == 0 or a_l[0] < a_r[0]):
        result.append(a_l.pop(0))
      else:
        result.append(a_r.pop(0))
    print(a_l, a_r, result)
    return result

original_a = [1, 5, 2, 9, 4, 0]
sorted_a = merge_sort(original_a, 0, len(original_a))
print(sorted_a)
