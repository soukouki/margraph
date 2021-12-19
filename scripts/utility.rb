
def root_dir_path(target)
  return '.' if target == './'
  '../'*target.count('/')
end