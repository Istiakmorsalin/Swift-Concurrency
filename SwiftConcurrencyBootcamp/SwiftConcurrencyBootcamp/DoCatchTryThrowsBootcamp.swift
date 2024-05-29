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
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("new string", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
}

class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
       let returnedValue =  manager.getTitle()
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
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
