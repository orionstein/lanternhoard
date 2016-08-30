import {Injectable}     from 'angular2/core';
import {Http, Response, Headers, RequestOptions} from 'angular2/http';
import {Observable}     from 'rxjs/Observable';
import {StoreEntry}           from './storeEntry'

@Injectable()
export class StoreService {

  constructor (private http: Http) {}

  private baseUrl = '/*@echo API_URL*/'+'/*@echo API_SHARD*/';
  private dataUrl = this.baseUrl+'/kdStoreGetItems';  // URL to web api
  private pageUrl = this.baseUrl+'/kdStorePageItems';  // URL to web api
  private apiUrl =  this.baseUrl+'/kdStoreSubscribe';  // URL to web api

  public firstItem;
  public lastItem;

  loadMoreEntries() {
    let lmUrl = this.pageUrl + '/backward/' + this.lastItem.date + '/11';
    let getCall = this.http.get(lmUrl)
    .map(x => x.json())
    return getCall
  }

  getStoreEntry () {
    let getCall = this.http.get(this.dataUrl + '/11')
    .map(x => x.json())
    return getCall
  }

  startPolling(t){
    let pollCall = Observable.interval(60000) 
    .switchMap(() => {
      let pollUrl = this.pageUrl + '/forward/' + this.firstItem.date + '/11';
      return this.http.get(pollUrl)
    })
    .map(x => x.json())
    return pollCall
  }

  submitMobile(num) {
    let headers = new Headers({ 
      'Content-Type': 'application/json'
    });

    let options = new RequestOptions({ headers: headers });

    let body = JSON.stringify({ 'number': num })

    let putCall = this.http.put(this.apiUrl, body, options)
    return putCall
  }

}


