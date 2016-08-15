import {Component, OnInit} from 'angular2/core';
import {Router} from 'angular2/router';

@Component({
  selector: 'huntsman',
  templateUrl: 'app/huntsman/huntsman.component.html'
})
export class HuntsManComponent implements OnInit {

  constructor(private _router: Router ) { }

  ngOnInit() {
      ga('send', 'pageview', location.pathname,
      {
        title: 'Huntsman'
      });
  }

}

