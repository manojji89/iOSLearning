import UIKit
import Combine

func addTwoNumber(a: Int, b: Int) -> Int {
    a + b
}


let justPublisher = Just(addTwoNumber(a: 3, b: 4))

let justSubscriber = Subscribers.Sink<Int, Never> { completion in
    debugPrint(completion)
} receiveValue: { value in
    print(value)
}

let justSubscriber1 = Subscribers.Sink<Int, Never> { completion in
    debugPrint(completion)
} receiveValue: { value in
    print(value)
}


justPublisher.print().subscribe(justSubscriber)
justPublisher.subscribe(justSubscriber1)


struct Repository: Codable {
    var name: String
    var url: URL
}

let url = URL(string: "https://api.github.com/repos/johnsundell/publish")!
let publisher = URLSession.shared.dataTaskPublisher(for: url)


let cancellable = publisher.sink(receiveCompletion: { completion in
    
    switch completion {
    case .failure(let error):
        print(error)
    case .finished:
        print("finished")
    }
}, receiveValue: { value in
    let decoder = JSONDecoder()
    do {
        let repo = try decoder.decode(Repository.self, from: value.data)
        print(repo)
    } catch {
        
    }
})


let publisher1 = publisher.map(\.data).decode(type: Repository.self, decoder: JSONDecoder())
let cancellale1 = publisher1.sink { completion in
    
} receiveValue: { repoModel in
    print(repoModel.name)
    print(repoModel.url)
}

