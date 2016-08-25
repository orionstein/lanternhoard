import {Component, OnInit} from 'angular2/core';
import {Router} from 'angular2/router';
import {StoreEntry} from './storeEntry';
import {StoreService} from './store.service';

@Component({
  selector: 'storewatch',
  templateUrl: 'app/storewatch/storeWatch.component.html',
  styleUrls: ['app/storewatch/storeWatch.component.css'],
  providers: [StoreService]
})
export class StoreWatchComponent implements OnInit {

  private storeEntries: StoreEntry[]

  constructor(private _router: Router, private _store: StoreService ) { }

  ngOnDestroy(){
    delete this.elm;
    this.pollStore = false;
  }

  ngOnInit() {

    let _this = this;

    this.modals = {
      successModal: false,
      errorModal: false
    }

    this.pollStore = true;

    this.elm = Elm.StoreWatchElm.embed(document.getElementById('store-watch-elm-embed'));
    this._store.getStoreEntry()
    .subscribe( entries => {
      _this.storeEntries = entries;
      _this._store.firstItem = _.head(_this.storeEntries);
      _this._store.lastItem = _.last(_this.storeEntries);
      setTimeout(function(){
        _this.elm.ports.entries.send(_this.storeEntries);
      }, 0);
      _this._store.startPolling()
      .takeWhile(function(e){ 
        if (_this.pollStore) { 
          return true; 
        } else { 
          return false; } 
      })
      .subscribe( entries => {
        if (entries)
        {
          _this.storeEntries = entries.concat(_this.storeEntries);
          _this._store.firstItem = _.head(_this.storeEntries);
          _this._store.lastItem = _.last(_this.storeEntries);
          _this.elm.ports.entries.send(_this.storeEntries);
        }
      })
    })


    this.elm.ports.action.subscribe( msg => {
      let action = JSON.parse(msg);
      ga('send', {
        hitType: 'event',
        eventCategory: 'Subscription',
        eventAction: 'SubscribeMobile',
        eventLabel: 'StoreWatch'
      });
      if (action.number !== '')
      {
        this._store.submitMobile(action.number)
        .subscribe( r => {
          this.modals.successModal = true;
          ga('send', {
            hitType: 'event',
            eventCategory: 'Subscription',
            eventAction: 'SubscribeMobileSuccess',
            eventLabel: 'StoreWatch'
          });
        }, e => {
          this.modals.errorModal = true;
          ga('send', {
            hitType: 'event',
            eventCategory: 'Subscription',
            eventAction: 'SubscribeMobileFailure',
            eventLabel: 'StoreWatch'
          });
        } )
      }
    } )

    ga('send', 'pageview', location.pathname,
       {
         title: 'StoreWatch'
       });
  }

  closeModal(modal){
    this.modals[modal] = false;
  }

  closeModals(){
    this.modals.successModal = false;
    this.modals.errorModal = false;
  }

  updateFeed(data) {
    let _this = this;
    this.elm.ports.entries.send(data);
  }

  loadMore() {
    let _this = this;
    console.log('bwah');
    this._store.loadMoreEntries()
    .subscribe( entries => {
      console.log(entries);
      console.log('bwah');
      _this.storeEntries = _this.storeEntries.concat(entries);
      console.log(_this.storeEntries);
      _this._store.firstItem = _.head(_this.storeEntries);
      _this._store.lastItem = _.last(_this.storeEntries);
      _this.elm.ports.entries.send(_this.storeEntries);
    });
  }
}



