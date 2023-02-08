import {abi} from "./abi.js";

import { ethers } from "ethers";

function connectWallet() {
    try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        await provider.send("eth_requestAccounts", []);
        const signer = provider.getSigner()
        
        setWalletConnected(true);
      } catch (err) {
        console.error(err);
}
}

function getUserPledge() {

    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();


    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );

    const userPledge = AAContract.getPledge();

    return userPledge;
}

function pledge(_amount) {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );
      try {
        await AAContract.pledge(_amount);
        window.alert("\nThank you for your donation!\n");
    }
     catch (err) {
    window.alert(
      "\n\n\n NOT ENOUGH MONEYS !\n\n\n"
    );
    console.log(err.message);
     }
}


function isProgramStarted() {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );

    const isProgramStarted = AAContract.isProgramStarted();

}

function addUsers(_address) {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );
      try {
        await AAContract.addUsers(_address);
        window.alert("\n User Added to program!\n");
    }
     catch (err) {
    window.alert(
      " try again "
    );
    console.log(err.message);
     }
}

function addManager(_address) {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );
      try {
        await AAContract.addManager(_address);
        window.alert("\n User Added to program!\n");
    }
     catch (err) {
    window.alert(
      " try again "
    );
    console.log(err.message);
     }
}

function removeManager(_address) {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );
      try {
        await AAContract.addManager(_address);
        window.alert("\n User Added to program!\n");
    }
     catch (err) {
    window.alert(
      " try again "
    );
    console.log(err.message);
     }
}


function startProgram(willStart) {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );
      try {
        await AAContract.startProgram(willStart);
        window.alert("\n User Added to program!\n");
    }
     catch (err) {
    window.alert(
      " try again "
    );
    console.log(err.message);
     }
}

function endProgram(willStart) {
    const AAaddress = "0x66cDdFEDa103169489bE7b398d96F475691aC11c";
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();

    const AAContract = new ethers.Contract(
        AAaddress,
        abi,
        signer
      );
      try {
        await AAContract.endProgram(willStart);
        window.alert("\n User Added to program!\n");
    }
     catch (err) {
    window.alert(
      " try again "
    );
    console.log(err.message);
     }
}



