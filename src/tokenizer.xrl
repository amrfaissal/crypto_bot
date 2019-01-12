Definitions.

OF              = (O|o)(F|f)
TO              = (T|t)(O|o)
AND             = (A|a)(N|n)(D|d)
PRICE           = (P|p)(R|r)(I|i)(C|c)(E|e)
WHITESPACE      = [\s\t\r\n]+
COMMA           = (,)
AMPERSAND       = (\&)
SYMBOL          = (usd|jpy|eur|btc|xrp|mad|tnd|ltc|xml|eth)

Rules.

{OF}            : {token, {of_, list_to_binary(TokenChars)}}.
{TO}            : {token, {to_, list_to_binary(TokenChars)}}.
{PRICE}         : {token, {price, list_to_binary(TokenChars)}}.
{SYMBOL}        : {token, {symbol, list_to_binary(TokenChars)}}.
{AND}           : {token, {and_, ","}}.
{COMMA}         : {token, {and_, ","}}.
{AMPERSAND}     : {token, {and_, ","}}.
{WHITESPACE}    : skip_token.

Erlang code.