System.register(['angular2/core', 'angular2/http', 'rxjs/Observable'], function(exports_1, context_1) {
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
    var core_1, http_1, Observable_1;
    var StoreService;
    return {
        setters:[
            function (core_1_1) {
                core_1 = core_1_1;
            },
            function (http_1_1) {
                http_1 = http_1_1;
            },
            function (Observable_1_1) {
                Observable_1 = Observable_1_1;
            }],
        execute: function() {
            StoreService = (function () {
                function StoreService(http) {
                    this.http = http;
                    //private url = 'https://s3.amazonaws.com/kingdomdeath/kingdomdeathstore.json';  // URL to web api
                    this.dataUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStoreGetItems'; // URL to web api
                    this.pageUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStorePageItems'; // URL to web api
                    this.apiUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStoreSubscribe'; // URL to web api
                }
                StoreService.prototype.loadMoreEntries = function () {
                    var lmUrl = this.pageUrl + '/backward/' + this.lastItem.date + '/10';
                    var getCall = this.http.get(lmUrl)
                        .map(function (x) { return x.json(); });
                    return getCall;
                };
                StoreService.prototype.getStoreEntry = function () {
                    var getCall = this.http.get(this.dataUrl)
                        .map(function (x) { return x.json(); });
                    return getCall;
                };
                StoreService.prototype.startPolling = function (t) {
                    var _this = this;
                    var pollCall = Observable_1.Observable.interval(60000)
                        .switchMap(function () {
                        var pollUrl = _this.pageUrl + '/forward/' + _this.firstItem.date + '/10';
                        return _this.http.get(pollUrl);
                    })
                        .map(function (x) { return x.json(); });
                    return pollCall;
                };
                StoreService.prototype.submitMobile = function (num) {
                    var headers = new http_1.Headers({
                        'Content-Type': 'application/json'
                    });
                    var options = new http_1.RequestOptions({ headers: headers });
                    var body = JSON.stringify({ 'number': num });
                    var putCall = this.http.put(this.apiUrl, body, options);
                    return putCall;
                };
                StoreService = __decorate([
                    core_1.Injectable(), 
                    __metadata('design:paramtypes', [http_1.Http])
                ], StoreService);
                return StoreService;
            }());
            exports_1("StoreService", StoreService);
        }
    }
});
