import {Injectable}     from 'angular2/core';
import {Http, Response, Headers, RequestOptions} from 'angular2/http';
import {Observable}     from 'rxjs/Observable';
import {StoreEntry}           from './storeEntry'

@Injectable()
export class StoreService {

  constructor (private http: Http) {}

  //private url = 'https://s3.amazonaws.com/kingdomdeath/kingdomdeathstore.json';  // URL to web api
  private dataUrl = 'https://s3.amazonaws.com/kingdomdeath/kingdomdeathstore.json';  // URL to web api
  private apiUrl = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/dev/kdStoreSubscribe';  // URL to web api

  getStoreEntry () {
    let getCall = this.http.get(this.dataUrl)
    .map(x => x.json())
    return getCall
  }

  startPolling(t){
    return Observable.interval(60000) 
    .switchMap(() => this.http.get(this.dataUrl))
    .map(x => x.json());
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


