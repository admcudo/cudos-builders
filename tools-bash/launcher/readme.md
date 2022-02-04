# Overview

The goal of this project is to start the primary-validator in a cluster with its corresponding seed and sentry nodes.

## Prerequirements 

The number of machines must be equal to the number of nodes, because each node runs on a standalone machine.

The machines must be connected in a private network with an internet connection.

The PC, where the script will run, must be able to connect to each of nodes' machines via SSH using keys. The account used for SSH must be able to execute "sudo" without asking for password, e.g. it must be part of "sudoers". More information can be found <a href="https://www.cyberciti.biz/faq/linux-unix-running-sudo-command-without-a-password/">here</a>

At least 500GB free space

Docker must be installed

Docker-compose must be installed

# Config

All of the config files are in ./laucher/config folder.

**Important: Do not leave any comments in any .env file**

## Step 1

Prepare the .env based on .env.example. It contains the following variables:
1. **PARAM_ETH_RPC:** a RPC endpoint of an Ethereum node. This is used for orchestrators. <em>Example: PARAM_ETH_RPC="http://1.2.3.4:8545"</em>
2. **PARAM_CONTRACT_DEPLOYER_ETH_PRIV_KEY:** a private key of an address with some ETH for gravity bridge contract deployment. <em>Example: PARAM_CONTRACT_DEPLOYER_ETH_PRIV_KEY="ae1341352513513a7f9a9a7a9a9a08a6a4a5f6ea9204135f1f3e1a3b1dae413e"</em>
3. **PARAM_SOURCE_DIR:** this is the dir on which the nodes home dir will be, usually we use something like "/usr/cudos" <em>Example: PARAM_SOURCE_DIR="/usr/cudos"</em>

## Step 2

Prepare the .env files for each of the nodes.

**Validator:**

Clone <em>validator.env.example</em> to <em>validator.mainnet.env</em> (The actual name could be arbitrary because the absolute path to this file is specified below in the configuration). It contains the following variables:
1. **MONIKER:** The name of the node. You could safely use the default value provided in the .example file. <em>Example: MONIKER="cudos-root-node-mainnet"</em>
1. **CHAIN_ID:** The id of the chain. DO NOT MODIFY THIS VALUE. Leave it "cudos-1" as it is in the example.
1. **ORCH_ETH_ADDRESS:** The ETH address of the the wallet that will be used by the orchestrator. <em>Example: ORCH_ETH_ADDRESS="0x582436824932f3b313e3a3b3d3e31413be6d6a"</em>
1. **MONITORING_ENABLED:** This variable defined whether the code will export data to port 26660 for prometheus. If the monitoring is disabled the port 26660 will be closed, otherwise it will be opened to the internal private interface. <em>Example: MONITORING_ENABLED="false"</em>
1. **ADDR_BOOK_STRICT:** This defines the behaviour of the internal address book. DO NOT MODIFY THIS VALUE. Leave it "true" as it is in the example.
1. **GRAVITY_MODULE_BALANCE:** This value defined the initial balance of the Gravity module in acudos. <em>Example: GRAVITY_MODULE_BALANCE="8000000000000000000000000000"</em>

**Seed:**

Clone <em>seed.env.example</em> to <em>seed.mainnet.env</em> (The actual name could be arbitrary because the absolute path to this file is specified below in the configuration). It contains the following variables:

1. **MONIKER:** The name of the node. You could safely use the default value provided in the .example file. <em>Example: MONIKER="cudos-seed-node-mainnet-01"</em>
1. **PERSISTENT_PEERS:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **PRIVATE_PEERS:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **SEEDS:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **SHOULD_USE_GLOBAL_PEERS:** DO NOT MODIFY THIS VALUE. Leave it "false" as it is in the example.
1. **SHOULD_USE_STATE_SYNC:** DO NOT MODIFY THIS VALUE. Leave it "false" as it is in the example.
1. **MONITORING_ENABLED:** This variable defined whether the code will export data to port 26660 for prometheus. If the monitoring is disabled the port 26660 will be closed, otherwise it will be opened to the internal private interface. <em>Example: MONITORING_ENABLED="false"</em>
1. **EXTERNAL_ADDRESS:** This variable defines the address to advertise to peers for them to dial. It must be the public address of the node plus the 26656 (or any other external number that could be redirected to internal port 26656) port. <em>Example: EXTERNAL_ADDRESS="43.14.14.12:26656"</em>
1. **ADDR_BOOK_STRICT:** This defines the behaviour of the internal address book. DO NOT MODIFY THIS VALUE. Leave it "true" as it is in the example.

**Sentry:**

Clone <em>sentry.env.example</em> to <em>sentry.mainnet.env</em> (The actual name could be arbitrary because the absolute path to this file is specified below in the configuration). It contains the following variables:

1. **MONIKER:** The name of the node. You could safely use the default value provided in the .example file. <em>Example: MONIKER="cudos-sentry-node-mainnet-01"</em>
1. **PERSISTENT_PEERS:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **PRIVATE_PEERS:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **SEEDS:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **SHOULD_USE_GLOBAL_PEERS:** DO NOT MODIFY THIS VALUE. Leave it "false" as it is in the example.
1. **SHOULD_USE_STATE_SYNC:** DO NOT MODIFY THIS VALUE. Leave it "false" as it is in the example.
1. **TLS_ENABLED**: DO NOT MODIFY THIS VALUE. Leave it "false" as it is in the example.
1. **MONITORING_ENABLED:** This variable defined whether the code will export data to port 26660 for prometheus. If the monitoring is disabled the port 26660 will be closed, otherwise it will be opened to the internal private interface. <em>Example: MONITORING_ENABLED="false"</em>
1. **EXTERNAL_ADDRESS:** This variable defines the address to advertise to peers for them to dial. It must be the public address of the node plus the 26656 (or any other external number that could be redirected to internal port 26656) port. <em>Example: EXTERNAL_ADDRESS="43.14.14.12:26656"</em>
1. **ADDR_BOOK_STRICT:** This defines the behaviour of the internal address book. DO NOT MODIFY THIS VALUE. Leave it "true" as it is in the example.

**Orchestrator:**

Clone <em>orchestrator.env.example</em> to <em>orchestrator.mainnet.env</em> (The actual name could be arbitrary because the absolute path to this file is specified below in the configuration). It contains the following variables:

1. **ADDRESS_PREFIX:** DO NOT MODIFY THIS VALUE. Leave it "cudos" as it is in the example.
1. **FEES:** The amount of fees, with acudos suffix, that are paid by the orchestrator when he iteracts with the blockchain. The value must be large enough to ensure that a transaction will be included by some validator in a block. <em>Example: FEES="1000acudos"</em>
1. **GRPC:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **ETHRPC:** Address to the ethereum full node. <em>Example: ETHRPC="http://43.14.14.12:8545"</em>
1. **CONTRACT_ADDR:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **COSMOS_ORCH_MNEMONIC:** DO NOT MODIFY THIS VALUE. Leave it empty as it is in the example.
1. **ETH_PRIV_KEY_HEX:** The private key of the address defined in ORCH_ETH_ADDRESS of <em>validator.mainnet.env</em>. <em>Example: ETH_PRIV_KEY_HEX="ae1341352513513a7f9a9a7a9a9a08a6a4a5f6ea9204135f1f3e1a3b1dae413e"</em>

## Step 3

Prepare the topology of the cluster based on the example. Clone <em>topology.json.example</em> to <em>topology.json</em>

**<code>topology.json</code> is a json file has the following structure:**

```json
{
    "computers": Computer[], // Defines each computer where a node will be deployed.
    "nodes": Node[], // Defines the topology of the network.
}
```

**Computer** object:

Each **computer** defined in the <code>topology.json</code> is accessed by a private key, username and private key's pass.

```json
{
    "id": string, // The id of the computer. It is used as a unique identifier of the machine.
    "ip": string, // The IP of the computer.
    "internalIp": string, // The internal IP of the computer. It will be used for communication betweek the computers themselves.
    "port": number, // The SSH service port. Usually it is 22.
    "user": string, // The SSH service user.
    "sshKeyPath": string, // Absolute path of the sshKey.
    "pass": string // The password of the sshKey.
}
```

**Node** object:
```json
{
    "primary-validator": Validator, // Defines the root validator, e.g. the one that starts the network.
    "seeds": Seed[], // Defines the seed nodes and how they are attached to validators.
    "sentries": Sentry[], // Defines the sentry nodes and how they are attached to validators.
}
```

**Validator** object:
```json
{
    "computerId": string, // The id of the computer where this node will run.
    "envPath": string, // Absolute path to the validator.mainnet.env created in step 2 of the config section above
    "orchEnvPath": string, // Absolute path to the orchestrator.mainnet.env craeted in step 2 of the config section above
}
```

**Seed** object:
```json
{
    "computerId": string, // The id of the computer where this node will run.
    "envPath": string, // Absolute path to the seed.mainnet.env created in step 2 of the config section above
}
```

**Sentry** object:
```json
{
    "computerId": string, // The id of the computer where this node will run.
    "envPath": string, // Absolute path to the seed.mainnet.env created in step 2 of the config section above
}
```

**<em>Remarks:</em>**
- Each **computer** instance can be used only by a single node.
- Each **validator** must have at least one **seed** and one **sentry**.

# Usage

There are 2 scripts.

**Important**: The side effect of executing any of these scripts will be a folder, defined in PARAM_SOURCE_DIR at .env, on each machine defined in topology.json

**Launcher**: It starts the cluster.

Ensure that it has execute permission and then start the script from ./launcher folder

```bash
./src/launcher.sh
```

**Validate**: It validates the connection from current machine to other machines defined in the topology and also checks for available space, software, etc.

Ensure that it has execute permission and then start the script from ./launcher folder

```bash
./src/validate-connection.sh
```


# To do

1. Add better verification and validation for all config files
1. Add genesis processing step