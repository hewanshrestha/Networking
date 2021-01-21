set netSimInstance [new Simulator]

set traceFile [open traceOutput.tr w]
set namFile [open namOutput.nam w]
$netSimInstance trace-all $traceFile
$netSimInstance namtrace-all $namFile

proc finish {}   {
    global netSimInstance traceFile namFile
    $netSimInstance flush-trace
    close $traceFile
    close $namFile
    exec nam namOutput.nam &
    exit 0
}

set node0 [$netSimInstance node]
set node1 [$netSimInstance node]
set node2 [$netSimInstance node]
set node3 [$netSimInstance node]
set node4 [$netSimInstance node]
set node5 [$netSimInstance node]
set node6 [$netSimInstance node]




$netSimInstance duplex-link $node1 $node0 1Mb 10ms DropTail
$netSimInstance duplex-link $node2 $node0 1Mb 10ms DropTail
$netSimInstance duplex-link $node3 $node0 1Mb 10ms DropTail
$netSimInstance duplex-link $node4 $node0 1Mb 70ms DropTail
$netSimInstance duplex-link $node5 $node0 1Mb 100ms DropTail
$netSimInstance duplex-link $node6 $node0 1000Mb 90ms DropTail

Agent/Ping instproc recv {from rtt} {
        $self instvar node_
        puts "node [$node_ id] received ping answer from \
              $from with round-trip-time $rtt ms."
}


set pingAgent1 [new Agent/Ping]
set pingAgent2 [new Agent/Ping]
set pingAgent3 [new Agent/Ping]
set pingAgent4 [new Agent/Ping]
set pingAgent5 [new Agent/Ping]
set pingAgent6 [new Agent/Ping]

$netSimInstance attach-agent $node1 $pingAgent1
$netSimInstance attach-agent $node2 $pingAgent2
$netSimInstance attach-agent $node3 $pingAgent3
$netSimInstance attach-agent $node4 $pingAgent4
$netSimInstance attach-agent $node5 $pingAgent5
$netSimInstance attach-agent $node6 $pingAgent6



$netSimInstance queue-limit $node0 $node1 1
$netSimInstance queue-limit $node0 $node2 2
$netSimInstance queue-limit $node0 $node3 0
$netSimInstance queue-limit $node0 $node4 2
$netSimInstance queue-limit $node0 $node5 2
$netSimInstance queue-limit $node0 $node6 2


$netSimInstance connect $pingAgent1 $pingAgent4
$netSimInstance connect $pingAgent2 $pingAgent5
$netSimInstance connect $pingAgent3 $pingAgent6

$netSimInstance at 0.1 "$pingAgent1 send"
$netSimInstance at 0.3 "$pingAgent2 send"
$netSimInstance at 0.5 "$pingAgent3 send"
$netSimInstance at 1.0 "$pingAgent4 send"
$netSimInstance at 1.2 "$pingAgent5 send"
$netSimInstance at 1.5 "$pingAgent6 send"
$netSimInstance at 2.0 "finish"


$netSimInstance run
