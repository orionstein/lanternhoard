System.register(['angular2/core', 'angular2/router', './store.service'], function(exports_1, context_1) {
    "use strict";
    var __moduleName = context_1 && context_1.id;
    var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
        var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
        if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
        else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
        return c > 3 && r && Object.defineProperty(target, key, r), r;
    };
    var __metadata = (this && this.__metadata) || function (k, v) {
        if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
    };
    var core_1, router_1, store_service_1;
    var StoreWatchComponent;
    return {
        setters:[
            function (core_1_1) {
                core_1 = core_1_1;
            },
            function (router_1_1) {
                router_1 = router_1_1;
            },
            function (store_service_1_1) {
                store_service_1 = store_service_1_1;
            }],
        execute: function() {
            StoreWatchComponent = (function () {
                function StoreWatchComponent(_router, _store) {
                    this._router = _router;
                    this._store = _store;
                }
                StoreWatchComponent.prototype.ngOnDestroy = function () {
                    delete this.elm;
                    this.pollStore = false;
                };
                StoreWatchComponent.prototype.ngOnInit = function () {
                    var _this = this;
                    var _this = this;
                    this.modals = {
                        successModal: false,
                        errorModal: false
                    };
                    this.pollStore = true;
                    this.elm = Elm.StoreWatchElm.embed(document.getElementById('store-watch-elm-embed'));
                    this._store.getStoreEntry()
                        .subscribe(function (entries) {
                        _this.hasMore = entries.hasMore;
                        _this.storeEntries = entries.items;
                        _this._store.firstItem = _.head(_this.storeEntries);
                        _this._store.lastItem = _.last(_this.storeEntries);
                        _this._store.lastItem.lastItem = true;
                        setTimeout(function () {
                            _this.elm.ports.entries.send(_this.storeEntries);
                        }, 0);
                        _this._store.startPolling()
                            .takeWhile(function (e) {
                            if (_this.pollStore) {
                                return true;
                            }
                            else {
                                return false;
                            }
                        })
                            .subscribe(function (entries) {
                            if (entries) {
                                _this.storeEntries = entries.items.concat(_this.storeEntries);
                                _this._store.firstItem = _.head(_this.storeEntries);
                                _this.elm.ports.entries.send(_this.storeEntries);
                            }
                        });
                    });
                    this.elm.ports.action.subscribe(function (msg) {
                        var action = JSON.parse(msg);
                        ga('send', {
                            hitType: 'event',
                            eventCategory: 'Subscription',
                            eventAction: 'SubscribeMobile',
                            eventLabel: 'StoreWatch'
                        });
                        if (action.number !== '') {
                            _this._store.submitMobile(action.number)
                                .subscribe(function (r) {
                                _this.modals.successModal = true;
                                ga('send', {
                                    hitType: 'event',
                                    eventCategory: 'Subscription',
                                    eventAction: 'SubscribeMobileSuccess',
                                    eventLabel: 'StoreWatch'
                                });
                            }, function (e) {
                                _this.modals.errorModal = true;
                                ga('send', {
                                    hitType: 'event',
                                    eventCategory: 'Subscription',
                                    eventAction: 'SubscribeMobileFailure',
                                    eventLabel: 'StoreWatch'
                                });
                            });
                        }
                    });
                    ga('send', 'pageview', location.pathname, {
                        title: 'StoreWatch'
                    });
                };
                StoreWatchComponent.prototype.closeModal = function (modal) {
                    this.modals[modal] = false;
                };
                StoreWatchComponent.prototype.closeModals = function () {
                    this.modals.successModal = false;
                    this.modals.errorModal = false;
                };
                StoreWatchComponent.prototype.updateFeed = function (data) {
                    var _this = this;
                    this.elm.ports.entries.send(data);
                };
                StoreWatchComponent.prototype.loadMore = function () {
                    var _this = this;
                    this._store.loadMoreEntries()
                        .subscribe(function (entries) {
                        _this.hasMore = entries.hasMore;
                        console.log(_this.hasMore);
                        _this._store.lastItem.lastItem = false;
                        _this.storeEntries = _this.storeEntries.concat(entries.items);
                        _this._store.firstItem = _.head(_this.storeEntries);
                        _this._store.lastItem = _.last(_this.storeEntries);
                        _this._store.lastItem.lastItem = true;
                        _this.elm.ports.entries.send(_this.storeEntries);
                    });
                };
                StoreWatchComponent = __decorate([
                    core_1.Component({
                        selector: 'storewatch',
                        templateUrl: 'app/storewatch/storeWatch.component.html',
                        styleUrls: ['app/storewatch/storeWatch.component.css'],
                        providers: [store_service_1.StoreService]
                    }), 
                    __metadata('design:paramtypes', [router_1.Router, store_service_1.StoreService])
                ], StoreWatchComponent);
                return StoreWatchComponent;
            }());
            exports_1("StoreWatchComponent", StoreWatchComponent);
        }
    }
});
