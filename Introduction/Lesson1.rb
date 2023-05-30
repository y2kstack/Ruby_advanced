MAX_NUM = 30000000

class SumUpExample
    def initialize(startRange, endRange)
        @counter = 0
        @startRange = startRange
        @endRange = endRange
    end

    def add()
        for i in @startRange..@endRange do
            @counter += i
        end
    end
    
    def getCounter
        return @counter
    end
end

def singleThread()
    s = SumUpExample.new(1, MAX_NUM)
    
    thread = Thread.new do
        s.add()
    end

    thread.join()
    return s.getCounter()
end
    

def runTwoThreads()
    s1 = SumUpExample.new(1, MAX_NUM / 2)
    s2 = SumUpExample.new(1 + (MAX_NUM / 2), MAX_NUM)
    thread1 = Thread.new do
        s1.add()
    end
    thread2 = Thread.new do
        s2.add()
    end
    thread1.join()
    thread2.join()
    return s1.getCounter() + s2.getCounter()
end

def runTwoProcesses()
    read1, write1 = IO.pipe
    read2, write2 = IO.pipe
    pid1 = Process.fork do
    s = SumUpExample.new(1, MAX_NUM / 2)
        s.add()
        write1.puts s.getCounter()
    end
    pid2 = Process.fork do
        s = SumUpExample.new(1 + (MAX_NUM / 2), MAX_NUM)
        s.add()
        write2.puts s.getCounter()
    end
    Process.wait pid1
    Process.wait pid2
    write1.close()
    write2.close()
    return (read1.read().to_i) + (read2.read().to_i)
end


starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = singleThread()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Single thread took : #{ending - starting} to sum to #{sum}"

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = runTwoThreads()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Two Threads took : #{ending - starting} to sum to #{sum}"

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = runTwoProcesses()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Two Processes took : #{ending - starting} to sum to #{sum}"
