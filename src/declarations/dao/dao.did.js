export const idlFactory = ({ IDL }) => {
  const StaticProposal = IDL.Record({
    'id' : IDL.Nat,
    'votesAgainst' : IDL.Int,
    'votesFor' : IDL.Int,
    'alreadyVoted' : IDL.Vec(IDL.Principal),
    'body' : IDL.Text,
  });
  return IDL.Service({
    'get_all_proposals' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Nat, StaticProposal))],
        ['query'],
      ),
    'get_cycles_balance' : IDL.Func([], [IDL.Nat], ['query']),
    'get_proposal' : IDL.Func([IDL.Nat], [IDL.Opt(StaticProposal)], ['query']),
    'get_tokens_owned' : IDL.Func([], [IDL.Nat], []),
    'submit_proposal' : IDL.Func(
        [IDL.Text],
        [IDL.Variant({ 'Ok' : StaticProposal, 'Err' : IDL.Text })],
        [],
      ),
    'update_site' : IDL.Func([IDL.Text], [], []),
    'vote' : IDL.Func(
        [IDL.Nat, IDL.Bool],
        [IDL.Variant({ 'Ok' : IDL.Tuple(IDL.Int, IDL.Int), 'Err' : IDL.Text })],
        [],
      ),
    'whoami' : IDL.Func([IDL.Text], [IDL.Text], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
