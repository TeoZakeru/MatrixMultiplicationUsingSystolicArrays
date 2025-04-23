import numpy as np

st = input()
ch = [st[i:i+4] for i in range(0, len(st), 4)]
# for i in ch:
  #  print(i)
chunks = [int(st[i:i+4],16) for i in range(0, len(st), 4)]
# A = np.array([[1,1,1,1,1,1,1,1],[2,2,2,2,2,2,2,2],[3,3,3,3,3,3,3,3],[4,4,4,4,4,4,4,4],[5,5,5,5,5,5,5,5],[6,6,6,6,6,6,6,6],[7,7,7,7,7,7,7,7],[8,8,8,8,8,8,8,8]])
np.random.seed(183)
A = np.random.randint(0,64,(8,8))
B = np.random.randint(0,64,(8,8))
chunks.reverse()
#print(len(chunks))
chunks = np.array(chunks).reshape((-1,8))
print(chunks == np.matmul(A,B.T))
#print(chunks)
#print(A)
# print(B)
print(np.matmul(A,B.T))
#print(int('1111',2))
