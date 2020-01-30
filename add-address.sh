#!/bin/sh
echo "full username: "
read fullname
node="http://localhost:8080"
if [ ! -d users/ ]; then
    mkdir "users"
fi
user_dir=users/${fullname}
if [ -d "${user_dir}" ]; then
    echo "${fullname} already exist"
else
    mkdir "${user_dir}"
    cd "${user_dir}"
    echo "Create new key pair..."
    java -jar ../../client/target/client-0.0.1-SNAPSHOT.jar --keypair
    cd ../..
fi
java -jar client/target/client-0.0.1-SNAPSHOT.jar --address --node "${node}" --name "${fullname}" --publickey "${user_dir}/key.pub"
echo "address hash: "
read address_hash
if [ -z "${address_hash}" ]; then
    echo "debug exit"
    exit
fi
cd "${user_dir}"
(
    echo "#!/bin/sh"
    echo "echo \"message: \""
    echo "read message"
    echo "java -jar ../../client/target/client-0.0.1-SNAPSHOT.jar --transaction --node \"${node}\" --sender \"${address_hash}\" --message \"\${message}\" --privatekey key.priv"
) > transaction.sh
chmod 777 transaction.sh