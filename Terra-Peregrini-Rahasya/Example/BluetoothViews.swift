//
//  BluetoothViews.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 09/07/24.
//

import SwiftUI

struct BluetoothViews: View {
    @StateObject private var bluetoothManager = BluetoothManager()
    @State private var textToSend: String = ""
    
    @State private var selectedColor = Color.red
    
    var body: some View {
        //        NavigationView {
        //
        //            List(bluetoothManager.peripherals) { discoveredPeripheral in
        //                VStack(alignment: .leading) {
        //                    Text(discoveredPeripheral.peripheral.name ?? "Unknown")
        //                        .font(.headline)
        //                    Text("RSSI: \(discoveredPeripheral.rssi)")
        //                        .font(.subheadline)
        //                }
        //            }
        //            //                }
        //            .navigationTitle("Discovered Peripherals")
        //        }
        VStack {
//            TextField("Enter text to send", text: $textToSend)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
            
            ColorPicker("Select a color", selection: $selectedColor)
                .padding()
            
            Button(action: {
                bluetoothManager.updateCharacteristicValue(with: UIColor(selectedColor))
            }) {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            bluetoothManager.receivedColor
                .frame(width: 100, height: 100)
            
            
            List(bluetoothManager.peripherals) { peripheral in
                VStack(alignment: .leading) {
                    Text(peripheral.peripheral.name ?? "Unknown")
                    Text("RSSI: \(peripheral.rssi)")
                }
            }
        }
        .onAppear {
            bluetoothManager.startScanning()
            bluetoothManager.startAdvertising()
        }
        .onDisappear {
            bluetoothManager.stopScanning()
            bluetoothManager.peripheralManager.stopAdvertising()
        }
    }
}

#Preview {
    BluetoothViews()
}
