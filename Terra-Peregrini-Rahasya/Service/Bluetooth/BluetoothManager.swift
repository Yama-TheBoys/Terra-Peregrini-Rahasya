//
//  BluetoothManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 09/07/24.
//

import UIKit
import CoreBluetooth
import SwiftUI

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var peripheralManager: CBPeripheralManager!
    
    var discoveredPeripherals: [DiscoveredPeripheral] = []
    var transferCharacteristic: CBMutableCharacteristic?
    
    @Published var peripherals: [DiscoveredPeripheral] = []
    
    @Published var receivedColor: Color = .white
    
    let serviceUUID = CBUUID(string: "9D3361E3-1E87-4AEA-90D6-5D993CF4DE3F") // Replace with your desired service UUID
    let characteristicUUID = CBUUID(string: "9D3361E3-1E87-4AEA-90D6-5D993CF4DE3F") // Replace with your desired characteristic UUID

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    // Central Manager Methods
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            startScanning()
        default:
            print("Central Manager state: \(central.state.rawValue)")
        }
    }

    func startScanning() {
        print("Starting scan for peripherals")
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: options)
    }

    func stopScanning() {
        print("Stopping scan for peripherals")
        centralManager.stopScan()
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "Unknown") with RSSI \(RSSI)")
        
        let rssiValue = RSSI.intValue
        
        let distance = calculateDistance(fromRSSI: rssiValue)
        
        if rssiValue >= -50 {
            print("Peripheral \(peripheral.name ?? "Unknown") is within 30cm. Distance: \(distance) meters")
            if !discoveredPeripherals.contains(where: { $0.peripheral.identifier == peripheral.identifier }) {
                let discoveredPeripheral = DiscoveredPeripheral(peripheral: peripheral, rssi: rssiValue)
                discoveredPeripherals.append(discoveredPeripheral)
                peripheral.delegate = self
                centralManager.connect(peripheral, options: nil)
                
                DispatchQueue.main.async {
                    self.peripherals.append(discoveredPeripheral)
                }
            }
        } else {
            // Remove peripheral if it is outside the distance threshold
            if let index = discoveredPeripherals.firstIndex(where: { $0.peripheral.identifier == peripheral.identifier }) {
                discoveredPeripherals.remove(at: index)
                centralManager.cancelPeripheralConnection(peripheral)
                
                DispatchQueue.main.async {
                    if let discoveredIndex = self.peripherals.firstIndex(where: { $0.peripheral.identifier == peripheral.identifier }) {
                        self.peripherals.remove(at: discoveredIndex)
                    }
                }
            }
        }

        // Find the peripheral with the highest RSSI value
        if let strongestPeripheral = discoveredPeripherals.max(by: { $0.rssi < $1.rssi }), rssiValue >= -30 {
            sendData(to: strongestPeripheral.peripheral, with: rssiValue)
        }
    }

    func calculateDistance(fromRSSI rssi: Int) -> Double {
        // Simplistic calculation for demonstration purposes
        let txPower = -59.0 // Reference txPower at 1 meter (typically -59dBm)
        let pathLossExponent = 2.0 // Path loss exponent (typical value)
        let ratio = pow(10.0, (Double(rssi) - txPower) / (10 * pathLossExponent))
        return ratio
    }

    // Handle successful connection
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown")")
        peripheral.discoverServices([serviceUUID])
    }

    // Handle failed connection
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to \(peripheral.name ?? "Unknown"): \(error?.localizedDescription ?? "No error info")")
        cleanUp(peripheral: peripheral)
    }

    // Handle disconnection
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from \(peripheral.name ?? "Unknown"): \(error?.localizedDescription ?? "No error info")")
        cleanUp(peripheral: peripheral)
        startScanning() // Optionally, start scanning again
    }
    
    func cleanUp(peripheral: CBPeripheral) {
        if let index = discoveredPeripherals.firstIndex(where: { $0.peripheral.identifier == peripheral.identifier }) {
            discoveredPeripherals.remove(at: index)
        }
        
        DispatchQueue.main.async {
            if let discoveredIndex = self.peripherals.firstIndex(where: { $0.peripheral.identifier == peripheral.identifier }) {
                self.peripherals.remove(at: discoveredIndex)
            }
        }
    }

    // Discover services
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Error discovering services: \(error.localizedDescription)")
            return
        }
        guard let services = peripheral.services else { return }
        for service in services {
            print("Discovered service: \(service.uuid)")
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }

    // Discover characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            return
        }
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == characteristicUUID {
                peripheral.setNotifyValue(true, for: characteristic)
                peripheral.readValue(for: characteristic)
            }
            print("Discovered characteristic: \(characteristic.uuid)")
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error updating value for characteristic: \(error.localizedDescription)")
            return
        }
        if characteristic.uuid == characteristicUUID {
            if let value = characteristic.value {
                let color = decodeColor(from: value)
                print("Received color: \(color)")
                receivedColor = Color(uiColor: color)
                transferCharacteristic?.value = nil
            }
        }
    }

    // Peripheral Manager Methods
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            startAdvertising()
        default:
            print("Peripheral Manager state: \(peripheral.state.rawValue)")
        }
    }

    func startAdvertising() {
        print("Starting advertising")
        let characteristic = CBMutableCharacteristic(type: characteristicUUID,
                                                     properties: [.read, .notify, .writeWithoutResponse],
                                                     value: nil,
                                                     permissions: [.readable, .writeable])
        
        let service = CBMutableService(type: serviceUUID, primary: true)
        service.characteristics = [characteristic]
        
        peripheralManager.add(service)
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
        transferCharacteristic = characteristic
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if let error = error {
            print("Error adding service: \(error.localizedDescription)")
            return
        }
        print("Service added: \(service.uuid)")
    }

    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("Error starting advertising: \(error.localizedDescription)")
            return
        }
        print("Started advertising.")
    }
    
    // Write value to the characteristic
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic.uuid == characteristicUUID {
                if let value = request.value {
                    let color = decodeColor(from: value)
                    print("Received color: \(color)")
                    // Respond to the write request
                    peripheralManager.respond(to: request, withResult: .success)
                    transferCharacteristic?.value = nil
                }
            }
        }
    }
    
    // Central reading the value from the characteristic
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        if request.characteristic.uuid == characteristicUUID {
            if let value = transferCharacteristic?.value {
                request.value = value
                peripheralManager.respond(to: request, withResult: .success)
                transferCharacteristic?.value = nil
            }
        }
    }
    
    // Update characteristic value
    func updateCharacteristicValue(with color: UIColor) {
        guard let transferCharacteristic = transferCharacteristic else { return }
        let data = encodeColor(color)
        transferCharacteristic.value = data
        peripheralManager.updateValue(data, for: transferCharacteristic, onSubscribedCentrals: nil)
    }
    
    // Encode UIColor to Data
    func encodeColor(_ color: UIColor) -> Data {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let redByte = UInt8(red * 255)
        let greenByte = UInt8(green * 255)
        let blueByte = UInt8(blue * 255)
        return Data([redByte, greenByte, blueByte])
    }

    // Decode Data to UIColor
    func decodeColor(from data: Data) -> UIColor {
        let red = CGFloat(data[0]) / 255.0
        let green = CGFloat(data[1]) / 255.0
        let blue = CGFloat(data[2]) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // Function to send data to the closest peripheral
    func sendData(to peripheral: CBPeripheral, with rssi: Int) {
        // Ensure that the peripheral is connected
        guard peripheral.state == .connected else {
            print("Peripheral \(peripheral.name ?? "Unknown") is not connected")
            return
        }
        
        // Update the characteristic value with the color data
        let color = UIColor.red // Example color to send
        let data = encodeColor(color)
        
        if let characteristic = transferCharacteristic {
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
            print("Sent color data to \(peripheral.name ?? "Unknown") with RSSI \(rssi)")
        } else {
            print("Transfer characteristic is not available")
        }
    }
}

struct DiscoveredPeripheral: Identifiable {
    let id = UUID()
    let peripheral: CBPeripheral
    let rssi: Int
}
