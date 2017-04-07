```sh
npm run build
```

Returns these errors

```sh
built/+basic.js:1: ERROR - "module$built$+basic" is not a valid ECMASCRIPT6 qualif
ied name
import { Component } from '@angular/core';
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

built/app.module.js:3: ERROR - required "module$built$+basic" namespace never prov
ided
import { Basic } from './+basic';
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

built/app.module.ngfactory.js:11: ERROR - required "module$built$+basic_ngfactory"
 namespace never provided
import * as import4 from './+basic.ngfactory';
```