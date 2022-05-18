//
//  ContentView.swift
//  Moonshot
//
//  Created by Rodrigo Tarouco on 10/05/22.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    
    
    @State private var displayList: Bool = false
    
    var body: some View {
        Group {
            if displayList {
                ListLayout(astronauts: astronauts, missions: missions)
                    .background(.darkBackground)
            } else {
                GridLayout(astronauts: astronauts, missions: missions)
                    .background(.darkBackground)
                
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle("Moonshot")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Toggle(isOn: $displayList) {
                    Text("Display as a List")
                }
                .foregroundColor(.white)
                .toggleStyle(.switch)
            }
        }
    }
}

struct GridLayout: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) {mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image).resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }.clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                        }
                    }
                }.padding([.horizontal, .bottom])
            }
        }
    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    HStack(spacing: 10) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        VStack {
                            Text(mission.displayName)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }.padding()
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.darkBackground)
        }
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
