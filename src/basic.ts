
import {Component, Injectable} from '@angular/core';

import '../node_modules/moment/moment';

declare const moment;

@Component({
  selector: 'basic',
  templateUrl: './basic.ng.html',
})
export class Basic {
  ctxProp: string;
  constructor() {
    this.ctxProp = moment.now().toString();
  }
}
