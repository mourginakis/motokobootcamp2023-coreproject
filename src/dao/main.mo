import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Int "mo:base/Int";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Prelude "mo:base/Prelude";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Cycles "mo:base/ExperimentalCycles";


actor {

    public type Proposal = {
        id:   Nat;
        var votesFor: Int;
        var votesAgainst: Int;
        body: Text;
        var alreadyVoted : [Principal];
    };

    public type StaticProposal = {
        id: Nat;
        votesFor: Int;
        votesAgainst: Int;
        body: Text;
        alreadyVoted : [Principal];
    };


    //
    // Data structures & stable
    stable var stableproposals : [(Nat, Proposal)] = [];
    let proposals = HashMap.fromIter<Nat, Proposal>(
        stableproposals.vals(), 10, Nat.equal, Hash.hash
    );


    // 
    // Utility functions
    public shared query (msg) func whoami(t : Text) : async Text {
        Principal.toText(msg.caller) # "" # t;
    };

    public query func get_cycles_balance() : async Nat {
        Cycles.balance();
    };

    func arrayContainsPrincipal(a : [Principal], p : Principal) : Bool {
        for (e in a.vals()) {
            if (e == p) {return true};
        };
        return false;
    };


    //
    // DAO Methods
    public shared({caller}) func submit_proposal(this_payload : Text) : async {#Ok : StaticProposal; #Err : Text} {
        let nextId = proposals.size() + 1;
        switch (proposals.get(nextId)) {
            case (?id) {
                return #Err("Error: too many proposals, 32bit int overflow");
            };
            case null {
                let nextProposal : Proposal = {
                    id = nextId;
                    var votesFor = 0;
                    var votesAgainst = 0;
                    body = this_payload;
                    var alreadyVoted = [];
                };
                proposals.put(nextId, nextProposal);
                return #Ok({
                    nextProposal with
                    votesFor = nextProposal.votesFor;
                    votesAgainst = nextProposal.votesAgainst;
                    alreadyVoted = [];
                })
            }
        }
    };


    type Subaccount = Blob;
    type Account = { 
        owner : Principal;
        subaccount : ?Subaccount;
    };
    let bootcamp_token_canister : actor { icrc1_balance_of : (Account) -> async Nat } = actor ("dpzjy-fyaaa-aaaah-abz7a-cai"); 


    public shared({caller}) func vote(proposal_id : Nat, yes_or_no : Bool) : async {#Ok : (Int, Int); #Err : Text} {
        let proposal = switch (proposals.get(proposal_id)) {
            case null {return #Err("Error: proposal does not exist");};
            case (?p) {p};
        };

        let tokens_owned = await bootcamp_token_canister.icrc1_balance_of({ owner = caller; subaccount = null; });
        if (not (tokens_owned > 1)) {
            return #Err("Number of Motoko Bootcamp Tokens must be greater than 1 to vote")
        };

        // Make sure principal hasn't already voted
        if (arrayContainsPrincipal(proposal.alreadyVoted, caller) == true) {
            return #Err("You can't vote twice");
        };

        Debug.print("you own tokens: " # debug_show(tokens_owned));
        let voting_power = tokens_owned;

        switch yes_or_no {
            case true { // Vote YES
                proposal.votesFor := proposal.votesFor + voting_power;
                proposal.alreadyVoted := Array.append(proposal.alreadyVoted, [caller]);
                if (proposal.votesFor > 100) { // Vote PASSES
                    ignore update_site(proposal.body);
                    switch (proposals.remove(proposal_id)) { // Proposal DELETE
                        case null {return #Err("Failed to remove proposal")};
                        case (?p) {return #Ok(0, 0)};
                    };
                };
            };
            case false { // Vote NO
                proposal.votesAgainst := proposal.votesAgainst + voting_power;
                if (proposal.votesAgainst > 100) { // Vote REJECT
                switch (proposals.remove(proposal_id)) { // Proposal DELETE
                    case null {return #Err("Failed to remove proposal")};
                    case (?p) {return #Ok(0, 0)};
                    };
                }
            };
        };

        return #Ok(proposal.votesFor, proposal.votesAgainst);
        // TODO: A proposal will automatically be passed if the cumulated voting power of all members that voted for it is equals or above 100.
        // TODO: A proposal will automatically be rejected if the cumulated voting power of all members that voted against it is equals or above 100.
        Prelude.unreachable()
    };
    
    
    
    let receiver : actor { receive_message : (Text) -> async Nat } = actor ("rrkah-fqaaa-aaaaa-aaaaq-cai"); 

    public func update_site(message : Text) : async () {
        let size = await receiver.receive_message(message);
        // return size;
    };

    public query func get_proposal(id : Nat) : async ?StaticProposal {
        switch (proposals.get(id)) {
            case null {return null};
            case (?proposal) {
                return ?{proposal with 
                votesFor = proposal.votesFor;
                votesAgainst = proposal.votesAgainst;
                alreadyVoted = [];
                }
            }
        }

    };
    
    public query func get_all_proposals() : async [(Nat, StaticProposal)] {
        let a = Iter.toArray(proposals.entries());
        Array.map<(Nat, Proposal), (Nat, StaticProposal)>(a, func (e) {
            (e.0, {e.1 with 
            votesFor = e.1.votesFor;
            votesAgainst = e.1.votesAgainst;
            alreadyVoted = [];
            });
        });
    };



    //
    // Upgrades
    system func preupgrade() {
        stableproposals := Iter.toArray(proposals.entries());
    };

    system func postupgrade() {
        stableproposals := [];
    };

};
