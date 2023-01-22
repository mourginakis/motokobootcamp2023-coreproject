import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface StaticProposal {
  'id' : bigint,
  'votesAgainst' : bigint,
  'votesFor' : bigint,
  'alreadyVoted' : Array<Principal>,
  'body' : string,
}
export interface _SERVICE {
  'get_all_proposals' : ActorMethod<[], Array<[bigint, StaticProposal]>>,
  'get_cycles_balance' : ActorMethod<[], bigint>,
  'get_proposal' : ActorMethod<[bigint], [] | [StaticProposal]>,
  'submit_proposal' : ActorMethod<
    [string],
    { 'Ok' : StaticProposal } |
      { 'Err' : string }
  >,
  'update_site' : ActorMethod<[string], undefined>,
  'vote' : ActorMethod<
    [bigint, boolean],
    { 'Ok' : [bigint, bigint] } |
      { 'Err' : string }
  >,
  'whoami' : ActorMethod<[string], string>,
}
