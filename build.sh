

root=/home/pi/git
cd $root

#git clone https://github.com/lancachenet/ubuntu.git || (cd "$root/ubuntu" ; git reset --hard ; git pull)
#git clone https://github.com/lancachenet/ubuntu-nginx.git || (cd "$root/ubuntu-nginx" ; git reset --hard ; git pull)
#git clone https://github.com/lancachenet/generic.git || (cd "$root/generic" ; git reset --hard ; git pull)
#git clone https://github.com/lancachenet/monolithic.git || (cd "$root/monolithic" ; git reset --hard ; git pull)

cd "$root/ubuntu"
docker build -t pegasy/lancachenet_ubuntu:latest .

s=ubuntu
n=ubuntu-nginx
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
docker build -t "pegasy/lancachenet_$n:latest" .

s=$n
n=generic
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
docker build -t "pegasy/lancachenet_$n:latest" .

s=$n
n=monolithic
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
docker build -t "pegasy/lancachenet_$n:latest" .


#cd "$root/ubuntu-nginx"
#sed -e 's/lancachenet\/ubuntu/pegasy\/lancachenet_ubuntu/g' -i Dockerfile
#docker build -t pegasy/lancachenet_ubuntu-nginx:latest .

#cd "$root/generic"
#sed -e 's/lancachenet\/ubuntu/pegasy\/lancachenet_generic/g' -i Dockerfile
#docker build -t pegasy/lancachenet_generic:latest .

#cd "$root/monolithic"
#sed -e 's/lancachenet\/monolithic/pegasy\/lancachenet_monolithic/g' -i Dockerfile
#docker build -t pegasy/lancachenet_monolithic .
