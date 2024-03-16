const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

async function TestContract() {
    const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;
    const provider = new ethers.JsonRpcProvider(
        `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
    );
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY_ETHER, provider);

    const abi = fs.readFileSync(
        "compilation/contracts_Test_sol_Greeter.json",
        "utf8",
    );
    const bytecode = fs.readFileSync(
        "compilation/contracts_Test_sol_Greeter.bin",
        "utf8",
    );

    const contractFactory = new ethers.ContractFactory(abi, bytecode, wallet);

    const contract = await contractFactory.deploy(
        "This is message from contract :)",
    );
    await contract.waitForDeployment();
    console.log("Contract deployed to address:", contract.target);

    // console.log(contractFactory);
    const greeting = await contract.greet();
    console.log(greeting);

    const balance = await contract.getBalance(
        process.env.ACCOUNT_ADDRESS_ETHER,
    );
    console.log(balance);

    const tx = await contract.sendEth(process.env.RECEIVER_ADDRESS_ETHER, {
        value: ethers.parseUnits("0.1", "ether"),
    });

    console.log(tx);

    console.log(balance);
}

async function main() {
    // await TestContract();
    console.log(ethers.parseUnits("0.01", "ether"));
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
