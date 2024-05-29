//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Istiak Morsalin on 5/28/24.
//

import SwiftUI

// do catch
// try
// throws

class DoCatchTryThrowsBootcampDataManager {
    
    let isActive: Bool = false
    
//    func getTitle() -> (title: String?, error: Error?) {
//        if isActive {
//            return ("new string", nil)
//        } else {
//            return (nil, URLError(.badURL))
//        }
//    }
    
    func getTitle() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT!")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "New Text!"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
//       let returnedValue =  manager.getTitle()
//        if let newTitle = returnedValue.title {
//            self.text = newTitle
//        } else if let error = returnedValue.error {
//            self.text = error.localizedDescription
//        }
        
//        let result = manager.getTitle()
//        
//        switch result {
//        case .success(let newTitle):
//            self.text = newTitle
//        case .failure(let error):
//            self.text = error.localizedDescription
//        }
        
        let newTitle = try? manager.getTitle3()
        
        if let newTitle = newTitle { 
            self.text = newTitle
        }
        
        do {
            let newTitle = try manager.getTitle3()
            self.text = newTitle
        } catch let error {
            self.text = error.localizedDescription
        }
    }
    
}
struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowsBootcamp()
}
