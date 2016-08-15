import {Component, OnInit} from 'angular2/core';
import {Router} from 'angular2/router';

@Component({
  selector: 'about',
  templateUrl: 'app/about/about.component.html'
})
export class AboutComponent implements OnInit {

  constructor(private _router: Router ) { }

  ngOnInit() {
      ga('send', 'pageview', location.pathname,
      {
        title: 'About'
      });
  }

}


