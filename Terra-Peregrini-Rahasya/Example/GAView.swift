//
//  GAView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 07/07/24.
//

import SwiftUI
import GroupActivities

struct ColorMission: GroupActivity {
    // Define a unique activity identifier for system to reference
    static let activityIdentifier = "com.tapera.mission.number.two"

    // App-specific data so your app can launch the activity on others' devices
//    let color: TransferColor
//    let truckName: String

    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = "You are smart enough to know this!"
//        metadata.subtitle = color.getColor().description
//        metadata.previewImage = UIImage(named: "ActivityImage")?.cgImage
        metadata.type = .generic
        return metadata
    }
    
//    static var transferRepresentation: some TransferRepresentation {
//        ProxyRepresentation(exporting: \.color)
//    }
}

struct GAView: View {
    
    @ObservedObject var viewModel: ColorMissionViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                viewModel.startSharing()
            }
            .task {
                for await session in ColorMission.sessions() {
                    viewModel.configureGroupSession(session)
                }
            }
    }
}

#Preview {
    GAView(viewModel: ColorMissionViewModel())
}

enum TransferColor: Codable {
    case red
    case green
    case blue
    case white
    
    func getColor() -> Color {
        switch self {
        case .red:
            Color.red
        case .green:
            Color.green
        case .blue:
            Color.blue
        case .white:
            Color.white
        }
    }
}

@MainActor
class ColorMissionViewModel: ObservableObject {
    
    var tasks = Set<Task<Void, Never>>()
    var messenger: GroupSessionMessenger?

    func startSharing() {
        Task {
            do {
                let activatinStatus = try await ColorMission().activate()
                print("status: \(activatinStatus)")
            } catch {
                print("Failed to activate SharePlay activity: \(error)")
            }
        }
    }
    
    func configureGroupSession(_ session: GroupSession<ColorMission>) {
        let messenger = GroupSessionMessenger(session: session)
        self.messenger = messenger
        
//        let task = Task {
////            for await (ColorMissionViewModel, _) in messenger.messages(of: ColorMissionViewModel.self) {
////
////            }
//        }
        session.join()
        print("Join session: \(session)")
    }
    
    func send() {
        Task {
            do {
                try await messenger?.send(TransferColor.blue)
            } catch {
                print("Error Send data: \(error.localizedDescription)")
            }
        }
    }
}
