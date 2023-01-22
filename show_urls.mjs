import fs from "fs"

const isDev = process.env["DFX_NETWORK"] !== "ic";
console.log(isDev);


// dfx deploy

let canisterIds
try {
  canisterIds = JSON.parse(
    fs
      .readFileSync(
        isDev ? ".dfx/local/canister_ids.json" : "./canister_ids.json",
      )
      .toString(),
  )
} catch (e) {
  console.error(e, "\n Before starting the dev server run: dfx deploy\n\n")
}

const candid_id = canisterIds.__Candid_UI["local"];
const assets_id = canisterIds.assets['local'];
const dao_id = canisterIds.dao['local'];
const webpage_id = canisterIds.webpage['local'];

console.log(`

Candid Interfaces:
DAO:     http://127.0.0.1:8000/?canisterId=${candid_id}&id=${dao_id}
Webpage: http://127.0.0.1:8000/?canisterId=${candid_id}&id=${webpage_id}

HTTP Interfaces:
Webpage: http://127.0.0.1:8000/?canisterId=${webpage_id}
Assets : http://127.0.0.1:8000/?canisterId=${assets_id}

vite server:
         http://localhost:3000/

`);


