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




~~~~~~~~~~~~~~~~~~~~~
#

The provided method `singleThread()` creates a new thread and performs a summation operation using an instance of the `SumUpExample` class. Here is a breakdown of the method:

1. `s = SumUpExample.new(1, MAX_NUM)`: This line creates a new instance of the `SumUpExample` class, passing `1` as the starting value and `MAX_NUM` as the maximum value for the summation.

2. `thread = Thread.new do`: This line starts the creation of a new thread using the `Thread.new` method. The `do` block following it contains the code that will be executed in the new thread.

3. `s.add()`: Inside the `do` block, `s.add()` invokes the `add()` method of the `SumUpExample` instance `s`. This method performs the summation operation.

4. `thread.join()`: This line waits for the newly created thread to finish executing before proceeding. The `join()` method ensures that the main thread waits for the completion of the `thread`.

5. `return s.getCounter()`: After the thread has finished its execution, the method returns the value of the counter variable from the `SumUpExample` instance `s` using the `getCounter()` method. This method retrieves the current value of the counter.

In summary, the `singleThread()` method creates a new thread to perform a summation operation using the `SumUpExample` class. By using threads, the method allows the summation to be executed concurrently with the main thread, potentially improving performance in scenarios where parallel execution is beneficial.

~~~~~~~~~~~~~~~~~~~~~

The provided method `runTwoProcesses()` utilizes process forking to execute two separate processes concurrently, each performing a summation operation using an instance of the `SumUpExample` class. Here is a breakdown of the method:

1. `read1, write1 = IO.pipe` and `read2, write2 = IO.pipe`: These lines create two pairs of pipes, `read1` and `write1`, and `read2` and `write2`. Pipes are a form of inter-process communication that allow data to be transferred between processes.

2. `pid1 = Process.fork do`: This line starts the creation of a new process using the `Process.fork` method. The block following it contains the code that will be executed in the new process.

3. `s = SumUpExample.new(1, MAX_NUM / 2)`, `s.add()`, `write1.puts s.getCounter()`: Inside the first process block, similar to the `singleThread()` method, a `SumUpExample` instance `s` is created, the summation is performed using `s.add()`, and the result is written to `write1` using `puts`.

4. `pid2 = Process.fork do`: This line starts the creation of another process using `Process.fork`. The block following it contains the code that will be executed in this new process.

5. `s = SumUpExample.new(1 + (MAX_NUM / 2), MAX_NUM)`, `s.add()`, `write2.puts s.getCounter()`: Inside the second process block, a new `SumUpExample` instance `s` is created, and the summation is performed on the remaining portion of the range. The result is written to `write2`.

6. `Process.wait pid1` and `Process.wait pid2`: These lines make the parent process wait for the completion of the child processes with IDs `pid1` and `pid2` using `Process.wait`.

7. `write1.close()` and `write2.close()`: The write ends of the pipes, `write1` and `write2`, are closed to indicate that no more data will be written to them.

8. `(read1.read().to_i) + (read2.read().to_i)`: The method reads the values written to `read1` and `read2`, converts them to integers, and returns their sum as the result of the method.

In summary, the `runTwoProcesses()` method utilizes process forking and inter-process communication to perform summation operations concurrently in two separate processes. This approach allows for potential performance improvements by leveraging parallel execution.

