# easychallenge

An app to simulate the return of an investment.

https://user-images.githubusercontent.com/4331095/131257097-886d4ece-3690-4cfb-aa6b-a7ab046ad149.mov


## Overview

The architecture used in this project was BLoc + repository pattern. I used two Cubits, one for the form screen, with the field's state, and another for the result screen, with the loading, success and error states. The navigation between those screens was made using the `pushNamed` method and a route defined in the `routes` attributes from the `MaterialApp`.

The repository pattern was used to encapsulate the knowledge of the data source and a special tratement of the data. Futhermore, I used a mix of the feature by package (ex.: `screens` package) and feature by type (ex.: `components` and `data` packages).

Finally, I added local tests with the main purpose of validate the repository behaviour and some utility functions. The widget tests were introduced to validate the form and result screens.

## Main dependencies
`flutter_bloc` - Used on the app's architecure.

`http` - Library to comunicate with a http api.

`shimmer` - Used to add loading animation in the result screen.

`intl` - Used to have access to number and data formaters.

`currency_text_input_formatter` - Used to add money formatter to `quanto você gostaria de aplicar?` field.

`mask_text_input_formatter` - Used to add date and rate formatters.
