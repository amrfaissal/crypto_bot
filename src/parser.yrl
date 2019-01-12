Terminals

symbol
price
to_
of_
.

Nonterminals

Statement
FromSymbol
ToSymbol
Price
.

Rootsymbol Statement.

FromSymbol -> symbol : '$1'.
ToSymbol -> symbol : '$1'.
Price -> price : '$1'.

Statement -> FromSymbol to_ ToSymbol: {fsym, extract_symbol('$1'), tsym, extract_symbol('$3')}.

Statement -> Price of_ FromSymbol: {fsym, extract_symbol('$3'), tsym, <<"EUR">>}.

Erlang code.

extract_symbol({symbol, Value}) -> string:uppercase(Value).
