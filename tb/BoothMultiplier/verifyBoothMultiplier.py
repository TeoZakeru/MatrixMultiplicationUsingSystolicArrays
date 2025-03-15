import subprocess
import multiprocessing
import re

def run_verilog_test(N):
    """Runs the Verilog testbench for a given N and verifies the output."""
    compile_cmd = ["iverilog", "-o", f"test_{N}.vvp", f"-P.tb_radix8_booth_multiplier.N={N}", "./tb.v", "../../src/BoothMultiplier/Radix-8-Booth-Multiplier.v"]
    run_cmd = ["vvp", f"test_{N}.vvp"]
    
    try:
        # Compile the Verilog code
        subprocess.run(compile_cmd, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
        # Run the simulation
        result = subprocess.run(run_cmd, capture_output=True, text=True, check=True)
        
        # Process and verify the output
        for line in result.stdout.split("\n"):
            match = re.match(r"\s*A\s*=\s*(-?\d+),\s*B\s*=\s*(-?\d+),\s*P\s*=\s*(-?\d+)", line)
            if match:
                A, B, P = map(int, match.groups())
                expected = A * B
                if P != expected:
                    print(f"[Error] N={N}, A={A}, B={B}, Expected P={expected}, Got P={P}")
                    return False
        print(f"[Success] N={N} passed all tests.")
        return True
    except subprocess.CalledProcessError as e:
        print(f"[Error] N={N} failed to compile or run: {e.stderr}")
        return False

if __name__ == "__main__":
    N_values = range(6, 36)  # N from 6 to 35
    with multiprocessing.Pool(processes=len(N_values)) as pool:
        results = pool.map(run_verilog_test, N_values)
    
    if all(results):
        print("All tests passed successfully.")
        subprocess.run('rm -rf *.vvp *.vcd', shell=True)
    else:
        print("Some tests failed. Check the error logs.")

