import numpy as np

def generate_testbench_feeding(A, B, size, data_width):
    assert A.shape == B.shape == (size, size), "A and B must be square matrices of the given size."

    def row_to_verilog(row):
        return ', '.join(f"{data_width}'d{val}" for val in row)

    tb = []

    for t in range(2*size - 1):
        # Prepare time-step A and B vectors
        A_vec = list(np.zeros(size, dtype=int))
        B_vec = list(np.zeros(size, dtype=int))
        for i in range(size):
            if 0 <= t - i < size:
                A_vec[i] = A[i, t - i]
                B_vec[i] = B[i, t - i]
        A_vec.reverse()
        B_vec.reverse()
        A_str = ', '.join(f"{data_width}'d{val}" for val in A_vec)
        B_str = ', '.join(f"{data_width}'d{val}" for val in B_vec)

        tb.append(f"        A = {{{A_str}}};")
        tb.append(f"        B = {{{B_str}}};")
        tb.append("        #10;")

    # Pad with zeros
    zero_line = f"        A = {size * data_width}'d0;"
    zero_line_B = f"        B = {size * data_width}'d0;"
    for _ in range(size):
        tb.append(zero_line)
        tb.append(zero_line_B)
        tb.append("        #10;")

    return '\n'.join(tb)

# Example input
# A = np.array([[1]*8, [2]*8, [3]*8, [4]*8, [5]*8, [6]*8, [7]*8, [8]*8])
# B = np.array([[1]*8, [2]*8, [3]*8, [4]*8, [5]*8, [6]*8, [7]*8, [8]*8])

np.random.seed(183)
A = np.random.randint(0,64,(8,8))
B = np.random.randint(0,64,(8,8))
# Generate testbench code
verilog_code = generate_testbench_feeding(A, B, size=8, data_width=32)
with open("systolic_array_tb.v", "w") as f:
    f.write(verilog_code)
