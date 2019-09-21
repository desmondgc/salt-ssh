# salt-ssh
salt-ssh Dockerfile

## Build
```
docker build -t salt-ssh .
```

## Setup
Create our `master` and `roster` config files (e.g.):

### `master`
```yaml
roster_defaults:
  user: ubuntu
  sudo: True
```

### `roster`
```yaml
web1: 10.0.0.1
web2: 10.0.0.2
```

## Usage
Set an alias to pass required options:
```bash
alias salt-ssh='docker run --rm \
    -v ~/salt-ssh/master:/etc/salt/master \
    -v ~/salt-ssh/roster:/etc/salt/roster \
    -v ~/.ssh/id_rsa:/etc/salt/pki/master/ssh/salt-ssh.rsa salt-ssh'
```

Now we can call `salt-ssh` as if it were installed locally:
```bash
salt-ssh '*' test.ping
```

## Notes
* Using PY3 version because PY2 pulls in both python2 and python3 dependencies on bionic
