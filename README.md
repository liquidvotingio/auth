# LiquidVotingAuth

```bash
docker run -it --rm \
  -e SECRET_KEY_BASE=$(mix phx.gen.secret) \
  -p 4000:4000 \
  docker.pkg.github.com/oliverbarnes/liquid-voting-auth/liquid-voting-auth:latest

curl -I http://localhost:4000 -H "Authorization: Bearer 1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"
  HTTP/1.1 200 OK
  cache-control: max-age=0, private, must-revalidate
  content-length: 0
  cross-origin-window-policy: deny
  date: Sat, 02 May 2020 17:35:59 GMT
  server: Cowboy
  x-content-type-options: nosniff
  x-download-options: noopen
  x-frame-options: SAMEORIGIN
  x-permitted-cross-domain-policies: none
  x-request-id: FgtGoxBd9FzfZxQAAAAl
  x-xss-protection: 1; mode=block

curl -I http://localhost:4000
HTTP/1.1 401 Unauthorized
cache-control: max-age=0, private, must-revalidate
content-length: 0
cross-origin-window-policy: deny
date: Sat, 02 May 2020 17:35:50 GMT
server: Cowboy
x-content-type-options: nosniff
x-download-options: noopen
x-frame-options: SAMEORIGIN
x-permitted-cross-domain-policies: none
x-request-id: FgtGoPrtxpyZk9gAAAAF
x-xss-protection: 1; mode=block

```
