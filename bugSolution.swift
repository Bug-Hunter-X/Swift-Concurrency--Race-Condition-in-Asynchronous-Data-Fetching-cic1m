func fetchData(completion: @escaping (Result<[Data], [Error]>) -> Void) {
    let group = DispatchGroup()
    var dataArray: [Data] = []
    var errors: [Error] = []
    let dispatchQueue = DispatchQueue(label: "dataFetchQueue")
    
    for i in 0..<5 {
        group.enter()
        URLSession.shared.dataTask(with: URL(string: "https://api.example.com/")!) { data, response, urlError in
            dispatchQueue.async {
                if let urlError = urlError {
                    errors.append(urlError)
                }
                if let data = data {
                    dataArray.append(data)
                }
                group.leave()
            }
        }.resume()
    }

    group.notify(queue: .main) {
        if errors.isEmpty {
            completion(.success(dataArray))
        } else {
            completion(.failure(errors))
        }
    }
}