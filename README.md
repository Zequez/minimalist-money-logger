# Minimalist Money Logger

    A money tracker so simple you actually stick with it


## The Problem

On multiple occasions I had the insight that I needed clarity
in the finantial area of my life. Being unaware of the money
I have access to and my rate of expediture and income, generates
a subtle feeling of anxiety surrounding money that works against
my intention of embracing an abundant mindset.

In my attempts to organize my finantial life, I've gone through
multiple attempts of hand-crafted spreadsheets, and numerous
money-tracking apps.

However it always ends up with the same problem: unless I can
add the expenses effortlessly, I end up completely abandoning
the money-tracking efforts.

## What Actually Worked

The tracking mechanism that I actually stuck to was to have a pinned Google Keep note with my expenses in the following fashion:

```
Default account Efectivo
Default currency ARS
Account Bank 3000ARS
Account Cash 2000ARS
Account BankUSD 200USD
Account Payoneer 50USD
Exchange Rate USD ARS 61.30
2020
Feb
1
1500 dentist. Bank -> Odontología Sol
450 radiography dentist. Bank -> Odontología Sol
400 fruits & veggies. Maxnic
2
110 tasty things. Festival Veganx
60 stickers Plaza Mitre. Random Seller
3
190 Ibuprofeno. Farmacia Bauza
200 coseguro dentist. Odontología Sol
4
1608 provisions. Bank -> Nutristock
5
100USD->6130 venta dólares. BankUSD -> Bank
6
-100USD sponsor payment. Payoneer
```

This way was so easy I stuck with for a long period of time.
However, it doesn't provide much in terms of insight and summaries
about the money. So it's not very useful. I just needed this, but with
some way to summarize the whole thing and maybe add colors.

## The Solution

I recently started developing on the [Elm programming language](https://elm-lang.org/), to create the Civitas Agora project for my community. I've been using [Bulma](http://bulma.io/) for styling and it's been a breeze. So I was feeling very enthusiastic about developing a pet project last Sunday because I'm not allowed to actually work on my main project (gotta give myself some well-deserved play time!)

Anyway, the solution I came up with was to recreate the ease of just writing text
with the power to process that text and provide some summaries and insights
automatically.

## Roadmap

- Base functionality with localstorage
- Host it on Netlify
- Sync with Firebase or something alike
- Set it up as PWA
- Share it with the world

## Credits

- [Elm Programming Language](https://elm-lang.org/)
- [Bulma CSS Framework](https://bulma.io/)
- [Elm Community](https://github.com/elm-community) (using list-extra)
- [Create Elm App](https://github.com/halfzebra/create-elm-app)

## GNU GPLv3

    Minimalist Money Logger
    Copyright (C) 2020 Ezequiel Zequez Schwartzman

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

Contact me at `zequez` on Gmail.
