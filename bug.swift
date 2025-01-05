func fetchData(completion: @escaping (Result<[Data], Error>) -> Void) {
    let group = DispatchGroup()
    var dataArray: [Data] = []
    var error: Error?
    for i in 0..<5 {
        group.enter()
        URLSession.shared.dataTask(with: URL(string: "https://api.example.com/")!) { data, response, urlError in
            if let urlError = urlError {
                error = urlError
            }
            if let data = data {
                dataArray.append(data)
            }
            group.leave()
        }.resume()
    }

    group.notify(queue: .main) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(dataArray))
        }
    }
}