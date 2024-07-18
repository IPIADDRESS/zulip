08f1e92484891f1326b24e9974d5e9eb
Click to copy
API Token
2ee954fbca29b3ff9711c49191d41080aa6d7f25050bda8d63b677d61fa263d7
Click to copy
Make sure to copy your API Token now. You won’t be able to see it again.
How to create credentials
You need to generate short-lived credentials for each TURN user. In order to create credentials, you should have a back-end service that uses your TURN Token ID and API token to generate credentials. It will need to make an API call like this:
curl -X POST \
    -H "Authorization: Bearer 2ee954fbca29b3ff9711c49191d41080aa6d7f25050bda8d63b677d61fa263d7" \
    -H "Content-Type: application/json" -d '{"ttl": 86400}' \
    https://rtc.live.cloudflare.com/v1/turn/keys/08f1e92484891f1326b24e9974d5e9eb/credentials/generate
Click to copy
The JSON response below can then be passed on to your front-end application to be used when creating the RTCPeerConnection:
{
    "iceServers": {
        "urls": [
            "stun:stun.cloudflare.com:3478",
            "turn:turn.cloudflare.com:3478?transport=udp",
            "turn:turn.cloudflare.com:3478?transport=tcp",
            "turns:turn.cloudflare.com:5349?transport=tcp"
        ],
        "username": "xxxx",
        "credential": "yyyy",
    }
}
