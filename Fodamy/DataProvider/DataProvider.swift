//
//  DataProvider.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

#if DEBUG
let apiDataProvider = APIDataProvider(eventMonitors: [APILogger.shared])
#else
let apiDataProvider = APIDataProvider(interceptor: APIRequestInterceptor.shared,
                                      eventMonitors: [])
#endif
