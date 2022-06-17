    o=0
    i=0
    while [ $i -le 359 ]
    do
    # the -N is super important here. Basically you send the transaction to the network and you don't wait for confirmation before going to the next one, effectively flooding the network with **valid transactions** and letting it figure out what the hell to do.
    goal clerk rawsend -N -f "/home/algotest/signed/signed${i}.stxn"
    i=$(($i+1))
    # I sleep 9 seconds, to let my system and the network catch up in the first pass. 10K Transactions should get processed in 10 seconds, so this is completely fine and will still flood the network.
    sleep 9
    done
    i=0
    #I start a second loop to spam whatever transactions are left. This time I don't sleep, I just send everything at once.
    while [ $o -le 5000 ]
    do
      while [ $i -le 359 ]
      do
      goal clerk rawsend -N -f "/home/algotest/signed/signed${i}.stxn"
      i=$(($i+1))
      done
    i=0
    o=$(($o+1))
    done
