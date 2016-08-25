import {Injectable}     from 'angular2/core';
import {Http, Response, Headers, RequestOptions} from 'angular2/http';
import {Observable}     from 'rxjs/Observable';
import {StoreEntry}           from './storeEntry'

@Injectable()
export class StoreService {

  constructor (private http: Http) {}

  //private url = 'https://s3.amazonaws.com/kingdomdeath/kingdomdeathstore.json';  // URL to web api
  private dataUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStoreGetItems';  // URL to web api
  private pageUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStorePageItems';  // URL to web api
  private apiUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStoreSubscribe';  // URL to web api

  public firstItem;
  public lastItem;

  loadMoreEntries() {
    let lmUrl = this.pageUrl + '/backward/' + this.lastItem.date + '/10';
    let getCall = this.http.get(lmUrl)
    .map(x => x.json())
    return getCall
  }

  getStoreEntry () {
    let getCall = this.http.get(this.dataUrl)
    .map(x => x.json())
    return getCall
  }

  startPolling(t){
    let pollCall = Observable.interval(60000) 
    .switchMap(() => {
      let pollUrl = this.pageUrl + '/forward/' + this.firstItem.date + '/10';
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


