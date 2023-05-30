This lesson introduces concurrency and provides motivational examples to further our understanding of concurrent
systems.


This code demonstrates different approaches to perform a summation operation and compares their execution times. Let's break it down step by step:

1. `MAX_NUM = 30000000`: This line sets a constant variable `MAX_NUM` to the value `30000000`. This constant represents the maximum number for the summation.

2. `class SumUpExample`: This is a class definition for `SumUpExample`. It has three methods:

   - `initialize(startRange, endRange)`: This method initializes an instance of `SumUpExample` with the provided `startRange` and `endRange` values. It sets the instance variables `@counter`, `@startRange`, and `@endRange`.
   
   - `add()`: This method performs the summation operation using a `for` loop, iterating over the range defined by `@startRange` and `@endRange`. It adds each value to the `@counter` instance variable.
   
   - `getCounter()`: This method returns the value of the `@counter` instance variable.

3. `def singleThread()`: This method demonstrates a single-threaded approach to perform the summation. It creates an instance of `SumUpExample` with a range from 1 to `MAX_NUM` and executes the summation in a separate thread. The method waits for the thread to finish using `join()`, and then returns the final sum.

4. `def runTwoThreads()`: This method demonstrates a multi-threaded approach using two threads to perform the summation concurrently. It creates two instances of `SumUpExample` with different ranges. Each instance runs in a separate thread, and both threads are waited for using `join()`. Finally, the sums from each thread are added together and returned.

5. `def runTwoProcesses()`: This method demonstrates a multi-process approach using two processes to perform the summation concurrently. It creates two pairs of pipes (`read1` and `write1`, `read2` and `write2`) for inter-process communication. Two child processes are forked. Each child process executes an instance of `SumUpExample` with different ranges and writes the sum to a respective pipe. The parent process waits for both child processes to finish using `Process.wait`, closes the write ends of the pipes, reads the sums from each pipe, converts them to integers, adds them together, and returns the final sum.

6. The code then measures the execution time of each approach using `Process.clock_gettime(Process::CLOCK_MONOTONIC)`. It calculates the time taken for each method, performs the summation, and outputs the execution time along with the resulting sum.

In summary, this code showcases different approaches to perform a summation operation in Ruby. It demonstrates a single-threaded approach, a multi-threaded approach using two threads, and a multi-process approach using two processes. The execution times for each approach are measured and compared.
