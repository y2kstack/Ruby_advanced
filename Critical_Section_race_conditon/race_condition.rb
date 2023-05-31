$randInt = rand(1..100)
mutex = Mutex.new

printerThread = Thread.new do
    while true
        mutex.synchronize do
            if $randInt % 5 == 0
                puts ("#{$randInt} is divisible by 5")
                if $randInt % 5 != 0
                    puts ("#{$randInt} is not divisible by 5")
                end
            end
        end
    end
end

updaterThread = Thread.new do

    while true
        mutex.synchronize do
            $randInt = rand(1..100)
        end
    end
end

sleep(20)
