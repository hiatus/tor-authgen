tor-authgen
======
Small script to generate server/client authentication files for version 3 onion services

Dependencies
------------
- **openssl**: provides `openssl`
- **coreutils**: provides `tr`, `base32` and `base64`

Usage
-----
- Clone the repository
```
user@host:~$ git clone https://github.com/hiatus/tor-authgen.git
```

- Run the script with a version 3 onion address as argument
```
user@host:~$ cd tor-authgen && chmod +x tor-authgen.sh
user@host:~/tor-authgen$ ./tor-authgen.sh igdi6j6vj1unffe1hpcmywf3qjs1qdv47l8m4llf756rpxwq8zq0lgb5.onion
[*] Public key:  MCowBQYDK2VuAyEAfmjOz0IPoeR9StuiAzrQ0PFt3DMpL9txYVqeLDSDhUQ=
[*] Private key: MC4CAQAwBQYDK2VuBCIEILhP8T4H/PhnlzqIK2Al3qxgmREiC7FipUTybTx8/DFA

[+] Check the working directory for .auth and .auth_private files
```

- Check the working directory for the generated files
```
user@host:~/tor-authgen$ ls
igdi6j6vj1unffe1hpcmywf3qjs1qdv47l8m4llf756rpxwq8zq0lgb5.auth          README.md
igdi6j6vj1unffe1hpcmywf3qjs1qdv47l8m4llf756rpxwq8zq0lgb5.auth_private  tor-authgen.sh
```

**Note**: generated files may be renamed (and probably should, as multiple clients require multiple `.auth` files on the server side), but `.auth` and `.auth_private` extensions must remain.

Reference
---------
- [Generating authentication credentials for Version 3 Onion services](https://github.com/AnarchoTechNYC/meta/wiki/Connecting-to-an-authenticated-Onion-service#generating-authentication-credentials-for-version-3-onion-services)
