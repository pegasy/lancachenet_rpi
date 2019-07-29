

root=/home/pi/git
cd $root

git clone https://github.com/lancachenet/ubuntu.git || (cd "$root/ubuntu" ; git reset --hard ; git clean -f -d ; git pull)
git clone https://github.com/lancachenet/ubuntu-nginx.git || (cd "$root/ubuntu-nginx" ; git reset --hard ; git clean -f -d ; git pull)
git clone https://github.com/lancachenet/generic.git || (cd "$root/generic" ; git reset --hard ; git clean -f -d ; git pull)
git clone https://github.com/lancachenet/monolithic.git || (cd "$root/monolithic" ; git reset --hard ; git clean -f -d ; git pull)
git clone https://github.com/lancachenet/lancache-dns.git || (cd "$root/lancache-dns" ; git reset --hard ; git clean -f -d ; git pull)
git clone https://github.com/lancachenet/sniproxy.git || (cd "$root/sniproxy" ; git reset --hard ; git clean -f -d ; git pull)

cd "$root/ubuntu"
docker build -t pegasy/lancachenet_ubuntu:latest .

s=ubuntu
n=ubuntu-nginx
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
docker build -t "pegasy/lancachenet_$n:latest" .

s=ubuntu-nginx
n=generic
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
sed -e "s/proxy_max_temp_file_size 40960m;/proxy_max_temp_file_size 1920m;/g" -i overlay/etc/nginx/sites-available/generic.conf.d/root/20_cache.conf
docker build -t "pegasy/lancachenet_$n:latest" .

s=generic
n=monolithic
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
echo "map_hash_bucket_size 128;" > overlay/etc/nginx/conf.d/15_set_map_hash_bucket_size.conf
docker build -t "pegasy/lancachenet_$n:latest" .

s=ubuntu
n=lancache-dns
cd "$root/$n"
sed -e "s/lancachenet\\/$s/pegasy\\/lancachenet_$s/g" -i Dockerfile
docker build -t "pegasy/lancachenet_$n:latest" .

n=sniproxy
cd "$root/$n"
docker build -t "pegasy/lancachenet_$n:latest" .

