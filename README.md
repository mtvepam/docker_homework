################## Описание 
С учетом рекомендаций сделано "руками" следующее:
 - созданы две подсети в докере c ip 192.168.110.0/24(frontend)  192.168.111.0/24 (backend и database)
 - созданы три образа frontend (c multi-staging) postgres (pull-ом) backend (с добавлением в него файла entrypoint.sh)
 - руками поправлены строки в /frontend/src/*.* localhost:8000 на my_IP:8000
 - /lib_catalog/lib_catalog/settings.py поправлен параметр ALLOWED_HOSTS = ['*'] (был пустой) и CORS_ORIGIN_ALLOW_ALL = True
 - из-за того, что перевод строки в Windows 10 не дружит с bash, применялось в PowerShell (Get-Content entrypoint.sh -Raw).Replace("`r`n","`n") | Set-Content entrypoint.sh -Force

################## Полный перечень команд, введенных с консоли 
docker network create --driver bridge --subnet 192.168.110.0/24 --ip-range 192.168.110.0/24 net110
docker network create --driver bridge --subnet 192.168.111.0/24 --ip-range 192.168.111.0/24 net111
docker pull postgres 
docker build -t frontend -f Dockerfile1 .
docker build -t backend -f Dockerfile2 .
docker-compose up -d

################## Описание файлов
Dockerfile1  - docker файл для frontend, build c multi-staging

Dockerfile2  - docker файл для backend, помимо рекомендованных requirements.txt, добавляет в образ entrypoint.sh 

entrypoint.sh - скрипт для создания superuser админки django, содержит запуск "manage.py migrate" и "python parse_docx.py"

.env - файл с переменными для создания пользователей superuser админки в backend  и django в БД

docker-compose.yml c применением всего вышеуказанного (открытые порты и переопределение кредишенов пользователей только в нем, порты backend(8000) и database(5432) открывались для проверки и снятия скриншотов).

С Уважением, Татьяна
P.S. ниже все, что осталось в консоли

D:\EPAM\stream 23\Dockertask>docker network create --driver bridge --subnet 192.168.110.0/24 --ip-range 192.168.110.0/24 net110
2e11938dfe59ab86ed3dcfc3814dcdac2ff107684140d36b28b507a820ce177c

D:\EPAM\stream 23\Dockertask>docker network create --driver bridge --subnet 192.168.111.0/24 --ip-range 192.168.111.0/24 net111
e81ba63eed89c21423201b66b565e7d8000fbc889209032497f7e601e149577e

D:\EPAM\stream 23\Dockertask>docker pull postgres
Using default tag: latest
latest: Pulling from library/postgres
a2abf6c4d29d: Pull complete
e1769f49f910: Pull complete
33a59cfee47c: Pull complete
461b2090c345: Pull complete
8ed8ab6290ac: Pull complete
495e42c822a0: Pull complete
18e858c71c58: Pull complete
594792c80d5f: Pull complete
794976979956: Pull complete
eb5e1a73c3ca: Pull complete
6d6360292cba: Pull complete
131e916e1a28: Pull complete
757a73507e2e: Pull complete
Digest: sha256:f329d076a8806c0ce014ce5e554ca70f4ae9407a16bb03baa7fef287ee6371f1
Status: Downloaded newer image for postgres:latest
docker.io/library/postgres:latest

D:\EPAM\stream 23\Dockertask>docker build -t frontend -f Dockerfile1 .
[+] Building 149.0s (15/15) FINISHED
 => [internal] load build definition from Dockerfile1                                                              0.0s
 => => transferring dockerfile: 323B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/nginx:1.20.2-alpine                                             2.6s
 => [internal] load metadata for docker.io/library/node:14                                                         2.7s
 => [build 1/7] FROM docker.io/library/node:14@sha256:50d4540794db9bdbd423a5823c4d840fc2ba0b9c82d71b059ff34b4aeb  72.1s
 => => resolve docker.io/library/node:14@sha256:50d4540794db9bdbd423a5823c4d840fc2ba0b9c82d71b059ff34b4aeb3e328f   0.0s
 => => sha256:8f9928bc52dae79625bc12279cb06dda2acb39b1480b602aee0fb03bf5f8c016 2.21kB / 2.21kB                     0.0s
 => => sha256:24d97ba03bf78cb05bd917ed99056ae1fe2cdd2d72d168fa77207e61065c9928 7.64kB / 7.64kB                     0.0s
 => => sha256:50d4540794db9bdbd423a5823c4d840fc2ba0b9c82d71b059ff34b4aeb3e328f 776B / 776B                         0.0s
 => => sha256:6a56b4def9c45045931a9cf99e9365b558347ae41ec8bfb104a7787e1c3129b0 45.38MB / 45.38MB                  18.9s
 => => sha256:ee0a7240797a1605f51c11e7c8f49754a8a78c89616dec348fa937886702d115 11.30MB / 11.30MB                   4.7s
 => => sha256:2fbb8704bdb1f04110dfee1bc6e00f421a37681ff4f136c12337f31c1ccd62bb 4.34MB / 4.34MB                     7.1s
 => => sha256:737a610bfddaa0e7c87d11580b07707489348ac0fb4cdf2f2265ff2e60246c1b 49.76MB / 49.76MB                  31.3s
 => => sha256:029c634f16083fa5280097e607f95223a8f029c6122c09ce9e41d86e4a26b639 214.46MB / 214.46MB                56.5s
 => => sha256:51d95cbd47b7407ab1f2245461e0cb211be28ca0180e4429b3880edfb58265b3 4.19kB / 4.19kB                    19.6s
 => => extracting sha256:6a56b4def9c45045931a9cf99e9365b558347ae41ec8bfb104a7787e1c3129b0                          2.4s
 => => sha256:3c8173903c76f9c8cfaf7097ea26b50c0429c9a0dd05de84e474d24089abb7f0 35.14MB / 35.14MB                  31.5s
 => => extracting sha256:ee0a7240797a1605f51c11e7c8f49754a8a78c89616dec348fa937886702d115                          0.5s
 => => extracting sha256:2fbb8704bdb1f04110dfee1bc6e00f421a37681ff4f136c12337f31c1ccd62bb                          0.2s
 => => sha256:51b090fe65f0713bd7e0050226bd2e742ade04bc1b3718775b9571e8b5652dc4 2.33MB / 2.33MB                    32.5s
 => => extracting sha256:737a610bfddaa0e7c87d11580b07707489348ac0fb4cdf2f2265ff2e60246c1b                          2.9s
 => => sha256:d7d734349a6c8e82e33eb473119c56d8092651caec4c9131a241bccd22570650 464B / 464B                        32.2s
 => => extracting sha256:029c634f16083fa5280097e607f95223a8f029c6122c09ce9e41d86e4a26b639                         12.6s
 => => extracting sha256:51d95cbd47b7407ab1f2245461e0cb211be28ca0180e4429b3880edfb58265b3                          0.0s
 => => extracting sha256:3c8173903c76f9c8cfaf7097ea26b50c0429c9a0dd05de84e474d24089abb7f0                          2.1s
 => => extracting sha256:51b090fe65f0713bd7e0050226bd2e742ade04bc1b3718775b9571e8b5652dc4                          0.1s
 => => extracting sha256:d7d734349a6c8e82e33eb473119c56d8092651caec4c9131a241bccd22570650                          0.0s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 749.84kB                                                                              0.0s
 => [stage-1 1/2] FROM docker.io/library/nginx:1.20.2-alpine@sha256:74694f2de64c44787a81f0554aa45b281e468c0c58b86  3.0s
 => => resolve docker.io/library/nginx:1.20.2-alpine@sha256:74694f2de64c44787a81f0554aa45b281e468c0c58b8665fafced  0.0s
 => => sha256:97518928ae5f3d52d4164b314a7e73654eb686ecd8aafa0b79acd980773a740d 2.82MB / 2.82MB                     0.7s
 => => sha256:a15dfa83ed30edc05f9ae19243b1697c31195bd7356b8d87d67651063559501a 7.24MB / 7.24MB                     1.9s
 => => sha256:74694f2de64c44787a81f0554aa45b281e468c0c58b8665fafceda624d31e556 1.65kB / 1.65kB                     0.0s
 => => sha256:f6609f898bcdad15047629edc4033d17f9f90e2339fb5ccb97da267f16902251 1.57kB / 1.57kB                     0.0s
 => => sha256:373f8d4d4c60c0ec2ad5aefe46e4bbebfbb8e86b8cf4263f8df9730bc5d22c11 8.88kB / 8.88kB                     0.0s
 => => sha256:acae0b19bbc1c5dbfbaaca8e18e71142217b3ba4905694feb9a5d8ed53543b67 602B / 602B                         0.6s
 => => sha256:fd4282442678c268be056b6f06d76ed2428f49025bcabb1cf5416d1b1991d39b 893B / 893B                         0.8s
 => => extracting sha256:97518928ae5f3d52d4164b314a7e73654eb686ecd8aafa0b79acd980773a740d                          0.2s
 => => sha256:b521ea0d9e3fea75017b5ea2628f86ebc70ab43fd58cf0623468b7d5912f5741 666B / 666B                         1.0s
 => => sha256:b3282d03aa58a4b6bb1536e30a426721d10e9ff2f84ae00dc1d4bbcfba97c458 1.40kB / 1.40kB                     1.1s
 => => extracting sha256:a15dfa83ed30edc05f9ae19243b1697c31195bd7356b8d87d67651063559501a                          0.4s
 => => extracting sha256:acae0b19bbc1c5dbfbaaca8e18e71142217b3ba4905694feb9a5d8ed53543b67                          0.0s
 => => extracting sha256:fd4282442678c268be056b6f06d76ed2428f49025bcabb1cf5416d1b1991d39b                          0.0s
[+] Building 98.3s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.8                                                      2.4s
 => [1/7] FROM docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737  95.8s
 => => resolve docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc7370  0.0s
 => => sha256:90e0a08f49f46afa33dc1eed864576f8bea8eac9e33d58a76970211aed85c0d3 2.22kB / 2.22kB                     0.0s
[+] Building 98.9s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
[+] Building 99.0s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
[+] Building 99.7s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.8                                                      2.4s
 => [1/7] FROM docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737  97.1s
 => => resolve docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc7370  0.0s
 => => sha256:90e0a08f49f46afa33dc1eed864576f8bea8eac9e33d58a76970211aed85c0d3 2.22kB / 2.22kB                     0.0s
 => => sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737059 1.86kB / 1.86kB                     0.0s
 => => sha256:ce9555db0df594866abb401599034c3757f37c45e98eae488386241b19c72d74 8.65kB / 8.65kB                     0.0s
 => => sha256:0e29546d541cdbd309281d21a73a9d1db78665c1b95b74f32b009e0b77a6e1e3 54.92MB / 54.92MB                  19.1s
 => => sha256:9b829c73b52b92b97d5c07a54fb0f3e921995a296c714b53a32ae67d19231fcd 5.15MB / 5.15MB                     3.4s
 => => sha256:cb5b7ae361722f070eca53f35823ed21baa85d61d5d95cd5a95ab53d740cdd56 10.87MB / 10.87MB                   5.7s
 => => sha256:6494e4811622b31c027ccac322ca463937fd805f569a93e6f15c01aade718793 54.57MB / 54.57MB                  26.4s
 => => sha256:6f9f74896dfa93fe0172f594faba85e0b4e8a0481a0fefd9112efc7e4d3c78f7 196.51MB / 196.51MB                52.6s
 => => sha256:fcb6d5f7c98604476fda91fe5f61be5b56fdc398814fb15f7ea998f53023e774 6.29MB / 6.29MB                    22.9s
 => => extracting sha256:0e29546d541cdbd309281d21a73a9d1db78665c1b95b74f32b009e0b77a6e1e3                          2.8s
 => => extracting sha256:9b829c73b52b92b97d5c07a54fb0f3e921995a296c714b53a32ae67d19231fcd                          0.2s
 => => extracting sha256:cb5b7ae361722f070eca53f35823ed21baa85d61d5d95cd5a95ab53d740cdd56                          0.4s
 => => sha256:35b0d149a82cb315c7d490f54f67bb122de76a15124c6524128fab47cba63bbd 16.81MB / 16.81MB                  28.3s
[+] Building 99.8s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.8                                                      2.4s
 => [1/7] FROM docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737  97.3s
[+] Building 100.1s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.8                                                      2.4s
 => [1/7] FROM docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737  97.6s
 => => resolve docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc7370  0.0s
 => => sha256:90e0a08f49f46afa33dc1eed864576f8bea8eac9e33d58a76970211aed85c0d3 2.22kB / 2.22kB                     0.0s
 => => sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737059 1.86kB / 1.86kB                     0.0s
 => => sha256:ce9555db0df594866abb401599034c3757f37c45e98eae488386241b19c72d74 8.65kB / 8.65kB                     0.0s
 => => sha256:0e29546d541cdbd309281d21a73a9d1db78665c1b95b74f32b009e0b77a6e1e3 54.92MB / 54.92MB                  19.1s
 => => sha256:9b829c73b52b92b97d5c07a54fb0f3e921995a296c714b53a32ae67d19231fcd 5.15MB / 5.15MB                     3.4s
 => => sha256:cb5b7ae361722f070eca53f35823ed21baa85d61d5d95cd5a95ab53d740cdd56 10.87MB / 10.87MB                   5.7s
 => => sha256:6494e4811622b31c027ccac322ca463937fd805f569a93e6f15c01aade718793 54.57MB / 54.57MB                  26.4s
 => => sha256:6f9f74896dfa93fe0172f594faba85e0b4e8a0481a0fefd9112efc7e4d3c78f7 196.51MB / 196.51MB                52.6s
 => => sha256:fcb6d5f7c98604476fda91fe5f61be5b56fdc398814fb15f7ea998f53023e774 6.29MB / 6.29MB                    22.9s
 => => extracting sha256:0e29546d541cdbd309281d21a73a9d1db78665c1b95b74f32b009e0b77a6e1e3                          2.8s
 => => extracting sha256:9b829c73b52b92b97d5c07a54fb0f3e921995a296c714b53a32ae67d19231fcd                          0.2s
[+] Building 100.3s (4/11)
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
[+] Building 154.3s (12/12) FINISHED
 => [internal] load build definition from Dockerfile2                                                              0.0s
 => => transferring dockerfile: 264B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.8                                                      2.4s
 => [1/7] FROM docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc73  137.1s
 => => resolve docker.io/library/python:3.8@sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc7370  0.0s
 => => sha256:90e0a08f49f46afa33dc1eed864576f8bea8eac9e33d58a76970211aed85c0d3 2.22kB / 2.22kB                     0.0s
 => => sha256:4c4e6735f46e7727965d1523015874ab08f71377b3536b8789ee5742fc737059 1.86kB / 1.86kB                     0.0s
 => => sha256:ce9555db0df594866abb401599034c3757f37c45e98eae488386241b19c72d74 8.65kB / 8.65kB                     0.0s
 => => sha256:0e29546d541cdbd309281d21a73a9d1db78665c1b95b74f32b009e0b77a6e1e3 54.92MB / 54.92MB                  19.1s
 => => sha256:9b829c73b52b92b97d5c07a54fb0f3e921995a296c714b53a32ae67d19231fcd 5.15MB / 5.15MB                     3.4s
 => => sha256:cb5b7ae361722f070eca53f35823ed21baa85d61d5d95cd5a95ab53d740cdd56 10.87MB / 10.87MB                   5.7s
 => => sha256:6494e4811622b31c027ccac322ca463937fd805f569a93e6f15c01aade718793 54.57MB / 54.57MB                  26.4s
 => => sha256:6f9f74896dfa93fe0172f594faba85e0b4e8a0481a0fefd9112efc7e4d3c78f7 196.51MB / 196.51MB                52.6s
 => => sha256:fcb6d5f7c98604476fda91fe5f61be5b56fdc398814fb15f7ea998f53023e774 6.29MB / 6.29MB                    22.9s
 => => extracting sha256:0e29546d541cdbd309281d21a73a9d1db78665c1b95b74f32b009e0b77a6e1e3                          2.8s
 => => extracting sha256:9b829c73b52b92b97d5c07a54fb0f3e921995a296c714b53a32ae67d19231fcd                          0.2s
 => => extracting sha256:cb5b7ae361722f070eca53f35823ed21baa85d61d5d95cd5a95ab53d740cdd56                          0.4s
 => => sha256:35b0d149a82cb315c7d490f54f67bb122de76a15124c6524128fab47cba63bbd 16.81MB / 16.81MB                  28.3s
 => => sha256:700a07047b6b1612c1dc2a9ce93ec19913d129206585879749e8fe177f567fa9 233B / 233B                        26.7s
 => => extracting sha256:6494e4811622b31c027ccac322ca463937fd805f569a93e6f15c01aade718793                          7.5s
 => => sha256:793b1b0c3ddfb6c3de731b9a027b6997bd786ff769648045a8f5a428a1406f5e 2.35MB / 2.35MB                    28.0s
 => => extracting sha256:6f9f74896dfa93fe0172f594faba85e0b4e8a0481a0fefd9112efc7e4d3c78f7                         73.9s
 => => extracting sha256:fcb6d5f7c98604476fda91fe5f61be5b56fdc398814fb15f7ea998f53023e774                          0.3s
 => => extracting sha256:35b0d149a82cb315c7d490f54f67bb122de76a15124c6524128fab47cba63bbd                          8.5s
 => => extracting sha256:700a07047b6b1612c1dc2a9ce93ec19913d129206585879749e8fe177f567fa9                          0.0s
 => => extracting sha256:793b1b0c3ddfb6c3de731b9a027b6997bd786ff769648045a8f5a428a1406f5e                          1.0s
 => [internal] load build context                                                                                  0.0s
 => => transferring context: 205.23kB                                                                              0.0s
 => [2/7] RUN pip install --upgrade pip                                                                            4.3s
 => [3/7] WORKDIR /app                                                                                             0.1s
 => [4/7] COPY ./lib_catalog/requirements.txt .                                                                    0.1s
 => [5/7] RUN pip install -r requirements.txt                                                                      9.2s
 => [6/7] COPY ./lib_catalog/ .                                                                                    0.1s
 => [7/7] COPY ./entrypoint.sh /app/entrypoint.sh                                                                  0.1s
 => exporting to image                                                                                             1.0s
 => => exporting layers                                                                                            1.0s
 => => writing image sha256:1294eac19edae15d6a27d6dce4593f721dc859ef662398c3e6e4b34d50b8845c                       0.0s
 => => naming to docker.io/library/backend                                                                         0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them

D:\EPAM\stream 23\Dockertask>docker images
REPOSITORY   TAG       IMAGE ID       CREATED              SIZE
backend      latest    1294eac19eda   About a minute ago   999MB
frontend     latest    cd018439c640   4 minutes ago        25.3MB
postgres     latest    07e2ee723e2d   11 days ago          374MB

D:\EPAM\stream 23\Dockertask>docker-compose up -d
Creating network "dockertask_net111" with the default driver
Creating network "dockertask_net110" with the default driver
Creating dockertask_frontend_1 ... done
Creating dockertask_database_1 ... done
Creating dockertask_backend_1  ... done

D:\EPAM\stream 23\Dockertask>docker container ls
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                    NAMES
2456772094b3   backend:latest    "bash /app/entrypoin…"   2 minutes ago   Up 2 minutes   0.0.0.0:8000->8000/tcp   dockertask_backend_1
0571c33b52e1   postgres:latest   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:5432->5432/tcp   dockertask_database_1
efa62a8fe50e   frontend:latest   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:80->80/tcp       dockertask_frontend_1

