enum RequestError: Error{
    case clientError
    case serverError
    case noData
    case dataEncodingError
}

func RequestErrorHandle(_ error: RequestError){
    switch error {
    case .clientError:
        print("client error")
    case .serverError:
        print("server error")
    case .noData:
        print("no data")
    case .dataEncodingError:
        print("enc error")
    default:
        print("something else")
    }
}
