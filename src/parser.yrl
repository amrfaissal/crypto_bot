Terminals

symbol
price
to_
of_
and_
.

Nonterminals

Statement
Symbol
Symbols
Price
.

Rootsymbol Statement.

Symbol -> symbol : '$1'.
Symbols -> Symbol and_ Symbols : ['$1'] ++ '$3'.
Symbols -> Symbol : ['$1'].
Price -> price : '$1'.

Statement -> Symbols to_ Symbols : {fsym, unwrap('$1'), tsym, unwrap('$3')}.
Statement -> Price of_ Symbols : {fsym, unwrap('$3'), tsym, [<<"EUR">>]}.
Statement -> Price Symbols : {fsym, unwrap('$2'), tsym, [<<"EUR">>]}.

Erlang code.

unwrap(Syms) -> [string:uppercase(Value) || {symbol, Value} <- Syms].
