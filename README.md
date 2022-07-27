Redis-Docker 설정
================
1. 사전 준비 작업
-------------------
- VirtualBox 박스 설치(다른 글 참고)
https://blog.naver.com/tawoo0/221555792642
- CentOS 7 다운로드
https://www.centos.org/download/ → DVD ISO 클릭
→ 미러 사이트 목록에서 링크선택(빨간색 박스의 목록에서 선택해야 빨리 받을 수 있음)

출처: <https://blog.naver.com/PostView.naver?blogId=tawoo0&logNo=221563030758&redirect=Dlog&widgetTypeCall=true&topReferer=https%3A%2F%2Fwww.google.com%2F&directAccess=false> 

- ifconfig가 안될때
yum install net-tools 

출처: <https://da2uns2.tistory.com/entry/CentOS-ifconfig-%EC%98%A4%EB%A5%98-%EC%A1%B4%EC%9E%AC%ED%95%98%EC%A7%80-%EC%95%8A%EC%9D%84-%EB%95%8C-%ED%95%B4%EA%B2%B0%EB%B2%95> 

2. Centos7 Docker , Docker Compose 설치
------------------------------------------------
* 도커설치(링크 참고)

https://docs.docker.com/engine/install/centos/

* Start Docker.

<pre>
 sudo systemctl start docker
</pre>

• 도커컴포즈 설치

Check the current release and if necessary, update it in the command below:

<pre>
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
</pre>

Next, set the permissions to make the binary executable:
<pre>
   sudo chmod +x /usr/local/bin/docker-compose
</pre>

Then, verify that the installation was successful by checking the version:
<pre>
 docker-compose --version
</pre>
출처: <https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-centos-7> 

3.  git 설치
------------

* root 계정일 경우 
<pre>
yum install git
</pre>
출처: <https://phodobit.kr/53> 

4.  git docker-compose 설정정보 얻기
------------------------------------------
<pre>
git init
git remote add origin "http://172.20.140.176:9010/heartwarm/docker-compose-redis.git"
git pull origin master
</pre>

5. docker build
-----------------
* redis-cluster home 이동
<pre>
 cd /home/redis/redis-cluster
</pre>

* docker build
<pre>
docker-compose -f conf/docker-compose.yml up --build -d
</pre>

6. maxdepth가 걸렸을 시 docker image 삭제
------------------------
<pre>
docker images
docker rmi [이미지ID] -f
</pre>

7. docker-compose shutdown
--------------------------------
<pre>
cd /home/redis/redis-cluster/conf
docker-compose down
</pre>

8. redis 설정정보 확인
---------------------------------
<pre>
docker exec -it conf_redis1_1 /bin/sh
redis-cli -h 127.0.0.1 -p [포트] -a [비밀번호]
info
config get protected-mode
config set protected-mode=no
</pre>


9.  클러스터 설정이 안됬을때
--------------------------------
<pre>
docker exec -it conf_redis1_1 /bin/sh
redis-cli --cluster fix IP:PORT -a password
</pre>
출처: <https://intrepidgeeks.com/tutorial/springboot-project-connected-to-redis-cluster-startup-error-incomplete-coverage-resources> 

10.  master 클러스터 merge
----------------------------
테스트
<pre>
redis-cli --cluster create 10.0.2.15:6379 10.0.2.15:6380 10.0.2.15:6381 -a asdf
</pre>
QA
<pre>
redis-cli --cluster create 10.14.1.18:7000 10.14.1.18:7001 10.14.1.18:7002 -a golfzon1!
</pre>
출처: <https://velog.io/@rivernine/redis-cluster-x-docker>


1.  포트가 열려있는지 확인
-----------------------------
<pre>
netstat -tulpn | grep LISTEN
</pre>
출처: <https://flyyunha.tistory.com/entry/centos7-%EC%82%AC%EC%9A%A9%EC%A4%91%EC%9D%B8-%ED%8F%AC%ED%8A%B8-%ED%99%95%EC%9D%B8> 