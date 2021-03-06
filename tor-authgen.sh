#!/bin/bash

usage()
{
	echo "$(basename ${0%.sh}) [v3 onion address]"
	exit ${1:-0}
}

gen_prv_key()
{
	openssl genpkey -algorithm x25519 | grep -v PRIVATE 2> /dev/null
}

gen_pub_key()
{
	{
		echo    "-----BEGIN PRIVATE KEY-----"
		echo -e "$1"
		echo    "-----END PRIVATE KEY-----"
	} |

	openssl pkey -pubout -outform PEM | grep -v PUBLIC  2> /dev/null
}


onion="${1%.onion*}"

if ! hash tr base{32,64} openssl 2> /dev/null; then
	deps=$(
		hash openssl        2> /dev/null || echo -n 'openssl '
		hash tr base{32,64} 2> /dev/null || echo -n 'coreutils'
	)

	usage 0 "Unmet dependencies: $deps"
fi

[[ ${#*} -eq 0 || "${*}" =~ -(h|-help) ]] && usage

if ! [[ "$onion" =~ ^[a-z0-9]{56}$ ]] ; then
	echo '[!] Invalid version 3 onion address'
	exit 1
fi

prv=$(gen_prv_key)
pub=$(gen_pub_key "$prv")

if [[ -z $prv || -z $pub ]]; then
	echo '[!] Failed to generate x25519 key pair'
	exit 3
fi

echo "[*] Public key:  ${pub}"
echo "[*] Private key: ${prv}"

prv_part=$(base64 -d <<< "$prv" | tail --bytes 32 | base32 -w 0 | tr -d '=')
pub_part=$(base64 -d <<< "$pub" | tail --bytes 32 | base32 -w 0 | tr -d '=')

echo "descriptor:x25519:${pub_part}" > "${onion}.auth"
echo "${onion}:descriptor:x25519:${prv_part}" > "${onion}.auth_private"

echo -e "\n[+] Check the working directory for .auth and .auth_private files"
