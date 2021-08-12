#! /bin/bash

#### make_index.sh
#### Created by Laurence D. Finston (LDF) Thu 12 Aug 2021 10:01:58 AM CEST

echo "\$1:"
echo $1

a=`expr index $1 "."`

echo "\$a:"
echo $a

b=`expr substr $1 1 $a`

echo "\$b:"
echo $b

c=${b}idx

echo "\$c:"
echo $c


sort $1 > $c

exit 0
