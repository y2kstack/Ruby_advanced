#deadlock

mutexA = Mutex.new
mutexB = Mutex.new

threadA = Thread.new do
    puts "Acquiring mutexA"
    mutexA.lock
    sleep(1)
    puts "Acquiring mutexB"
    mutexB.lock
    puts "Thread t1 exiting"
end


threadB = Thread.new do
    puts "Acquiring mutexB"
    mutexB.lock
    sleep(1)
    puts "Acquiring mutexA"
    mutexA.lock
    puts "Thread t2 exiting"
end


threadA.join()
threadB.join()
