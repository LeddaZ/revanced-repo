# How to set up build signing
You'll need the Java Development Kit (JDK), OpenSSL and Linux.
1. Create a new Java KeyStore with the following command

`keytool -keystore clientkeystore.jks -genkey -alias client`

2. Export your private key with the following command

`openssl base64 < clientkeystore.jks | tr -d '\n' | tee clientkeystore.jks.base64.txt`

3. Go to Settings -> Secrets -> Actions
4. Create the following secrets:
    - `SIGNING_KEY`: the contents of the clientkeystore.jks.base64.txt file
    - `ALIAS`: the alias specified with the -alias option earlier
    - `KEY_STORE_PASSWORD`: the KeyStore's password you entered earlier
    - `KEY_PASSWORD`: the key's password you entered earlier
