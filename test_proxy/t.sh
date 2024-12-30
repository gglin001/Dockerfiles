# https://docs.docker.com/engine/cli/proxy/
# https://stackoverflow.com/questions/27749193/how-to-build-docker-images-with-dockerfile-behind-http-proxy-by-jenkins

# run `docker build` in colima on macos
# colima ssh

###############################################################################

docker build -t test_proxy:latest --progress=plain --no-cache -f test_proxy/Dockerfile .

# check env
docker run --rm -it test_proxy:latest env

###############################################################################

# TODO: why not works(for colima)
http_proxy=http://host.lima.internal:10800
https_proxy=http://host.lima.internal:10800
no_proxy="localhost,127.0.0.0/8"
docker build -t test_proxy:latest --progress=plain --no-cache \
  --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy \
  --build-arg HTTP_PROXY=$http_proxy --build-arg HTTPS_PROXY=$https_proxy \
  --build-arg no_proxy=$no_proxy --build-arg NO_PROXY=$no_proxy \
  -f test_proxy/Dockerfile .

# TODO: why not works(for colima)
# try to edit `~/.docker/config.json`
# eg(for colima):
#
# "proxies": {
# 	"default": {
# 		"httpProxy": "http://host.lima.internal:10800",
# 		"httpsProxy": "http://host.lima.internal:10800",
# 		"noProxy": "localhost,127.0.0.0/8"
# 	}
# }
#
docker build -t test_proxy:latest --progress=plain --no-cache -f test_proxy/Dockerfile .

# only for clima
# if `~/.docker/config.json` not works
# try to edit `~/.colima/default/colima.yaml`
# eg:
# env:
#   HTTP_PROXY: http://host.lima.internal:10800
#   HTTPS_PROXY: http://host.lima.internal:10800
#   NO_PROXY: localhost,127.0.0.1
docker build -t test_proxy:latest --progress=plain --no-cache -f test_proxy/Dockerfile .

# check env
docker run --rm -it test_proxy:latest env

###############################################################################

docker run test_proxy:latest curl ip.gs

http_proxy=http://host.lima.internal:10800
https_proxy=http://host.lima.internal:10800
docker run --env http_proxy=$http_proxy --env https_proxy=$http_proxy \
  test_proxy:latest curl ip.gs

###############################################################################
