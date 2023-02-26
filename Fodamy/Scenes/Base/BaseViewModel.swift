//
//  BaseViewModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

protocol BaseViewModelDataSource: AnyObject {}

protocol BaseViewModelEventSource: AnyObject {
    var showActivityIndicatorView: VoidClosure? { get set }
    var hideActivityIndicatorView: VoidClosure? { get set }
    
    var showLoading: VoidClosure? { get set }
    var hideLoading: VoidClosure? { get set }
    
    var showWarningToast: StringClosure? { get set }
}

protocol BaseViewModelProtocol: BaseViewModelDataSource, BaseViewModelEventSource {}

class BaseViewModel: BaseViewModelProtocol {
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    var showLoading: VoidClosure?
    var hideLoading: VoidClosure?
    var showWarningToast: StringClosure?
    
    let dataProvider: DataProviderProtocol
    
    init(dataProvider: DataProviderProtocol = apiDataProvider) {
        self.dataProvider = dataProvider
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}
