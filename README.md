## Motoko Bootcamp DAO

DAO project for Code and State's 2023 Motoko Bootcamp


useful commands
```bash
npm install

dfx start --background --clean
dfx deploy
npm run dev
npm run show-urls


dfx canister create --all --network ic

// will also upgrade
dfx deploy --network ic 


```


Thanks to [Iri](https://twitter.com/iriasviel) for making the template for this project

Canister URL: [https://azrge-yaaaa-aaaag-qbrqa-cai.ic0.app/](https://azrge-yaaaa-aaaag-qbrqa-cai.ic0.app/)

Webpage Canister: [https://axtlm-dqaaa-aaaag-qbrra-cai.raw.ic0.app](https://axtlm-dqaaa-aaaag-qbrra-cai.raw.ic0.app)


Only works with plug wallet.


## Common (strange) error
- When using Plug wallet you might encounter the following: "Uncaught (in promise) Error: There isn't enough space to open the popup" - if that's the case make sure to reduce your browser windows and give some space for the popup windows to appear.
