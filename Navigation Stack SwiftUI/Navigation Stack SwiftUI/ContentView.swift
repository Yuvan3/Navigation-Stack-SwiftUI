//
//  ContentView.swift
//  Navigation Stack SwiftUI
//
//  Created by Yuvan Shankar on 09/04/2024.
//

import SwiftUI

struct CarBrand: Identifiable, Hashable {
    let name: String
    let id = NSUUID().uuidString
}

struct Car: Identifiable, Hashable {
    let id = NSUUID().uuidString
    let make: String
    let model: String
    let year: String
    
    var description: String {
        return "\(year) \(make) \(model)"
    }
}

struct ContentView: View {
    
    let brands: [CarBrand] = [
        .init(name: "Honda"),
        .init(name: "Toyoto"),
        .init(name: "Hyundai")
    ]
    
    let car: [Car] = [
        .init(make: "Honda", model: "Accord", year: "2024"),
        .init(make: "Toyoto", model: "Camry", year: "2022"),
        .init(make: "Hyundai", model: "Creta", year: "2023")
    ]
    
    @State private var navigationPath = [CarBrand]()
    @State private var showFullStack = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Manufacturer") {
                        ForEach(brands) { brand in
                            NavigationLink(value: brand) {
                                Text(brand.name)
                            }
                        }
                    }
                    
                    Section("Cars") {
                        ForEach(car) { car in
                            NavigationLink(value: car) {
                                Text(car.description)
                            }
                        }
                    }
                }
                .navigationDestination(for: CarBrand.self) { brand in
                    VStack {
                        viewForBrand(brand)
                        
                        Button("Go to root") {
                            navigationPath = []
                        }
                    }
                }
                
                .navigationDestination(for: Car.self) { car in
                    Color(.systemRed)
                    Text("New \(car.description)")
                }
                
                Button("View All") {
                    showFullStack.toggle()
                    
                    if showFullStack {
                        navigationPath = brands
                    } else {
                        navigationPath = [brands[0], brands[2]]
                    }
                }
            }
        }
    }
    
    func viewForBrand(_ brand: CarBrand) -> AnyView {
        switch brand.name {
        case "Honda":
            return AnyView(Color(.systemRed))
        case "Toyoto":
            return AnyView(Color(.systemBlue))
        case "Hyundai":
            return AnyView(Color(.systemTeal))
        default:
            return AnyView(Color(.systemGray))
        }
    }
}

#Preview {
    ContentView()
}
