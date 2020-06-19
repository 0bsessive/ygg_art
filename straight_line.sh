#!/bin/bash
export portN=3000
mkdir config
for i in {1..10};do
	export portB="$portN"
	export portN="$(echo $(($portN+1)))"
	yggdrasil -genconf > config/$i
	sed -i 's/unix:\/\/\/var\/run\/yggdrasil.sock/none/g' config/$i
	sed -i 's/\.\*//g' config/$i
	sed -i "s/Peers: \[\]/Peers: [\"tcp:\/\/127.0.0.1:$portB\"\]/g" config/$i
	sed -i "s/Listen: \[\]/Listen: \[\"tcp:\/\/0.0.0.0:$portN\"\]/g" config/$i
	screen -d -m yggdrasil -useconffile config/$i
done
