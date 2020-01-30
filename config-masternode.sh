#!/bin/sh
echo "url of master node: "
read address
echo ${address} > masternode-address.txt
(
    echo "package de.neozo.jblockchain.node;"
    echo
    echo
    echo "public abstract class Config {"
    echo
    echo "    /**"
    echo "     * Address of a Node to use for initialization"
    echo "     */"
    echo "    public static final String MASTER_NODE_ADDRESS = \"${address}\";"
    echo
    echo "    /**"
    echo "     * Minimum number of leading zeros every block hash has to fulfill"
    echo "     */"
    echo "    public static final int DIFFICULTY = 3;"
    echo
    echo "    /**"
    echo "     * Maximum numver of Transactions a Block can hold"
    echo "     */"
    echo "    public static final int MAX_TRANSACTIONS_PER_BLOCK = 5;"
    echo
    echo
    echo "}"
) > node/src/main/java/de/neozo/jblockchain/node/Config.java
echo "Don't forget to build (mvnw package)"