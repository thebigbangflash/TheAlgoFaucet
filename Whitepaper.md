## Project Description
https://thealgofaucet.com has always been a "community first" project. When the old faucet was taken offline in October 2021 by /u/CrabbyLandscape (he's still legendary for running the first faucet and a huge inspiration), I spent a weekend to learn everything I could about Algorand to replace it. I'm hosting an Algorand node and sending all transaction from it.

I am offering hosting of the website and my technical knowledge for free, the community is providing the funds to pay for transactions

As an incentive, when they donate to the faucet, they will receive the ASA : Algorand Faucet Drops - AFD - 393495312

## Mission
The goal is to provide a free service to the Algorand community using Algorand's philosophy of "doing the right thing for the sake of doing the right thing". The same philosophy behind the fact why there are no incentive for running a participation node. By helping the community, I'm helping myself since I'm a part of the Algorand community.

I started by offering the small faucet drops in November 2021 with the goal of automatically and daily compounding accounts for the rewards available on the blockchain. I've sent more than 200 000 drops since then!

Those Algorand Rewards are now phasing out by May 2022, although they'll be extremely low until then.

## New Mission / February 2022

There is now a new mission, provide a free staking service unlike any other. By using TheAlgoFaucet's service, you can provide holders of your ASA or Liquidity Pool Providers rewards based on how much they own. A very fair way to distribute rewards, very similar to the way the Algorand Blockchain did it.

My script can also be easily adjusted to reward NFT holders with another ASA.

The generic idea is "I check the blockchain for a value (all holders with a specific amount of an ASA), I then build transactions to send to those holders with specific parameters. Those adjustable parameters are at the end of this White Paper.

All transaction costs are paid for by donations to the Faucet.

I use a variation of the script I perfected by running the faucet for all those months. This script will be made available for anybody to use for **personal and commercial use** using the standard license format "GNU General Public License v3.0"

### The basic gist of the license is this : 

Weither you're using this personally or commercially, you have to use the same GPL v3.0 license and provide the source code of your scripts.

I provide no warranty on this script and am not liable if anything breaks or goes awry if you use it.

As a side note, I wouldn't use this script in a commercial environement anyways... If anything changes on Algorand's APIs, you're screwed and will have to adjust it on the fly, not the best way to run a business. I have so much free time and I know this script inside out so I can most likely personally adjust it in a few minutes.

## ASA - Algorand Faucet Drops - 393495312

Asset Information on AlgoExplorer: https://algoexplorer.io/asset/393495312

Creator / Distribution Wallet : FAUC7F2DF3UGQFX2QIR5FI5PFKPF6BPVIOSN2X47IKRLO6AMEVA6FFOGUQ

This is my Algorand Standard Asset. You can receive Algorand Faucet Drops (AFDs) by donating to the faucet. You need to have "opted-in" the asset before you can receive it. If you don't feel comfortable sending Algos with only a promise of receiving an ASA, which is totally understandable and honestly a very valid opinion to have in the blockchain space, you can also swap some Algos for them on Tinyman here : https://app.tinyman.org/#/swap?asset_in=0&asset_out=393495312

All donations are welcome! They help pay for transactions so I can keep offering free services to the Algorand community!

## Governance

Since the Algo pool for the faucet comes 100% from the community, I don't want to take decisions with that money without first consulting the community. I will offer a governance program at https://thealgofaucet.com/governance where holders of AFD - 393495312 will be able to vote on those questions to help decide how to bring the faucet forward.

This project is, and always will be at its core, a community project. 

## Socials

Website : https://thealgofaucet.com

Discord : https://discord.gg/NwWtYJ2pNj

## Stress Testing / other projects

Using what I learned by running the Faucet, I like to stress test the testnet network once in a while. 

One of my tests and a description here : https://www.reddit.com/r/algorand/comments/s5q7ne/i_attacked_algorands_network_testnet/

## List of Parameters which can be adjusted in the script.

ASA-Number to lookup : *Ex : 393495312*

ASA-Number to distribute : *Ex : 393495312*

Min Qty held to qualify : *Ex : 1000*

Daily % Compounding : *Ex : 1%*

LP-token-ASA-Number : *Ex : 552946222*

Min Qty held to qualify : *Ex : 1*

Daily LP reward : *Ex : 0.035 ASA per POOL token*

Accounts to exclude from staking : *Ex : Tinyman, Creator account*
