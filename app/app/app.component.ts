import {Component, OnInit} from 'angular2/core';
import {RouteConfig, ROUTER_DIRECTIVES, Router} from 'angular2/router';
import {HTTP_PROVIDERS}    from 'angular2/http';
import {HomeComponent} from './home/home.component';
import {StoreWatchComponent} from './storewatch/storeWatch.component';
import {HuntsManComponent} from './huntsman/huntsman.component';
import {AboutComponent} from './about/about.component';

@Component({
    selector: 'lanternhoard',
    templateUrl: 'app/app.component.html',
    directives: [ROUTER_DIRECTIVES],
    providers: [HTTP_PROVIDERS]
})

@RouteConfig([
  {path: '', name: 'Home', component: HomeComponent, useAsDefault: true}
  {path: 'storewatch', name: 'StoreWatch', component: StoreWatchComponent}
  {path: 'huntsman', name: 'HuntsMan', component: HuntsManComponent}
  {path: 'about', name: 'About', component: AboutComponent}
])

export class AppComponent implements OnInit {
    public title = 'The Lantern Hoard';

    constructor(private _router: Router) { }

    ngOnInit() {
      ga('send', 'pageview', location.pathname,
      {
        title: 'Homepage'
      });
    }
}
