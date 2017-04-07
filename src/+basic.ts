
import {Component, Injectable} from '@angular/core';

@Component({
  selector: 'basic',
  templateUrl: './basic.ng.html',
})
export class Basic {
  ctxProp: string;
  constructor() { this.ctxProp = 'initial value'; }
}
