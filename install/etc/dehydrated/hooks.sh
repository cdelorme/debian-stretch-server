#!/usr/bin/env bash

deploy_challenge() {
    local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
    # @note: example Digital Ocean API automation to create DNS-01 _acme-challenge validation record
    # local TOKEN=X
    # curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"TXT\",\"name\":\"_acme-challenge\",\"data\":\"$TOKEN_VALUE\"}" "https://api.digitalocean.com/v2/domains/${DOMAIN}/records"
}

clean_challenge() {
    local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
    # @note: example Digital Ocean API automation to cleanup after DNS-01 _acme-challenge validation record
    # local TOKEN=X
    # local OLD_RECORD=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/domains/$DOMAIN/records" | jq '[.domain_records[] | select(.name=="_acme-challenge")][0].id' -r)
    # [ "$OLD_RECORD" != "null" ] && curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$OLD_RECORD"
}

deploy_cert() {
    local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}" TIMESTAMP="${6}"
    # @note: ssl certificates can be symlinked to reduce file copies
    # @todo: if other systems need to be restarted, add them
    systemctl reload nginx
}

deploy_ocsp() {
    local DOMAIN="${1}" OCSPFILE="${2}" TIMESTAMP="${3}"
}


unchanged_cert() {
    local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}"
}

invalid_challenge() {
    local DOMAIN="${1}" RESPONSE="${2}"
}

request_failure() {
    local STATUSCODE="${1}" REASON="${2}" REQTYPE="${3}" HEADERS="${4}"
}

generate_csr() {
    local DOMAIN="${1}" CERTDIR="${2}" ALTNAMES="${3}"
}

startup_hook() {
  :
}

exit_hook() {
  :
}

HANDLER="$1"; shift
if [[ "${HANDLER}" =~ ^(deploy_challenge|clean_challenge|deploy_cert|deploy_ocsp|unchanged_cert|invalid_challenge|request_failure|generate_csr|startup_hook|exit_hook)$ ]]; then
  "$HANDLER" "$@"
fi
