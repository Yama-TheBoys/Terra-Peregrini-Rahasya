//
//  HomeService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import HomeKit

protocol HomeServiceDelegate: AnyObject {
    func didUpdateHomes(home: [HMHome])
}

final class HomeService: NSObject {
    
    let homeManager = HMHomeManager()
    
    weak var delegate: HomeServiceDelegate?
    
    override init() {
        super.init()
        homeManager.delegate = self
    }
    
    func checkAuthorization() -> HMHomeManagerAuthorizationStatus {
        homeManager.authorizationStatus
    }
    
    func checkRoomAvailability(room: HMRoom) -> (Bool,Bool) {
        var isLampAvailable = false
        var isDoorLockAvailable = false
        
        if room.accessories.contains(where: { accessory in
            accessory.findCharacteristic(type: HMCharacteristicTypePowerState) != nil
        }) {
            isLampAvailable = true
        }
        
        if room.accessories.contains(where: { accessory in
            accessory.findCharacteristic(type: HMCharacteristicTypeTargetLockMechanismState) != nil
        }) {
            isDoorLockAvailable = true
        }
        
        return (isLampAvailable, isDoorLockAvailable)
    }
    
    func toggleLight(accessory: HMAccessory) {
        guard let lightCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypePowerState) else {
            return
        }
        
        let currentValue = (lightCharacteristic.value as? Bool) ?? false
        lightCharacteristic.writeValue(!currentValue) { error in
            if let error = error {
                print("Error toggling light: \(error.localizedDescription)")
            } else {
//                DispatchQueue.main.async {
//                    self.objectWillChange.send()
//                }
            }
        }
    }
    
    func toggleDoorLock(accessory: HMAccessory) {
        guard let lockCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeTargetLockMechanismState) else {
            return
        }
        
        let currentValue = (lockCharacteristic.value as? Int) ?? 0
        let newValue = currentValue == HMCharacteristicValueLockMechanismState.secured.rawValue ? HMCharacteristicValueLockMechanismState.unsecured.rawValue : HMCharacteristicValueLockMechanismState.secured.rawValue
        lockCharacteristic.writeValue(newValue) { error in
            if let error = error {
                print("Error toggling door lock: \(error.localizedDescription)")
            } else {
//                DispatchQueue.main.async {
//                    self.objectWillChange.send()
//                }
            }
        }
    }
    
    func setSmartLampColor(for accessory: HMAccessory, color: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)) {
        guard let hueCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeHue),
              let saturationCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeSaturation),
              let brightnessCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeBrightness) else {
            print("Smart lamp color characteristics not found.")
            return
        }
        
        hueCharacteristic.writeValue(color.hue) { error in
            if let error = error {
                print("Error writing hue: \(error)")
                return
            }
            
            saturationCharacteristic.writeValue(color.saturation) { error in
                if let error = error {
                    print("Error writing saturation: \(error)")
                    return
                }
                
                brightnessCharacteristic.writeValue(color.brightness) { error in
                    if let error = error {
                        print("Error writing brightness: \(error)")
                    }
                }
            }
        }
    }
    
    func fetchSmartLampColor(for accessory: HMAccessory, completion: @escaping (CGFloat, CGFloat, CGFloat) -> Void) {
        guard let hueCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeHue),
              let saturationCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeSaturation),
              let brightnessCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeBrightness) else {
            return
        }
        
        hueCharacteristic.readValue { error in
            if let error = error {
                print("Error reading hue: \(error.localizedDescription)")
                return
            }
            
            saturationCharacteristic.readValue { error in
                if let error = error {
                    print("Error reading saturation: \(error.localizedDescription)")
                    return
                }
                
                brightnessCharacteristic.readValue { error in
                    if let error = error {
                        print("Error reading brightness: \(error.localizedDescription)")
                        return
                    }
                    
                    let hueValue = CGFloat((hueCharacteristic.value as? Float ?? 0.0))
                    let saturationValue = CGFloat(saturationCharacteristic.value as? Float ?? 0.0)
                    let brightnessValue = CGFloat(brightnessCharacteristic.value as? Float ?? 0.0)
                    
                    DispatchQueue.main.async {
                        completion(hueValue, saturationValue, brightnessValue)
                    }
                }
            }
        }
    }
    
    func setSmartLampBrightness(for accessory: HMAccessory, brightness: CGFloat) {
        guard let brightnessCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeBrightness) else {
            print("Smart lamp color characteristics not found.")
            return
        }
        
        
        brightnessCharacteristic.writeValue(brightness) { error in
            if let error = error {
                print("Error writing brightness: \(error)")
            }
        }

    }
    
    func fetchSmartLampBrightness(for accessory: HMAccessory, completion: @escaping (CGFloat) -> Void) {
        guard let brightnessCharacteristic = accessory.findCharacteristic(type: HMCharacteristicTypeBrightness) else {
            return
        }
        
        brightnessCharacteristic.readValue { error in
            if let error = error {
                print("Error reading brightness: \(error.localizedDescription)")
                return
            }
            let brightnessValue = CGFloat(brightnessCharacteristic.value as? Float ?? 0.0)
            
            DispatchQueue.main.async {
                completion(brightnessValue)
            }
        }
    }
}

extension HomeService: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        delegate?.didUpdateHomes(home: manager.homes)
    }
    
    func homeManagerDidUpdateAuthorization(_ manager: HMHomeManager) {
        if manager.authorizationStatus == HMHomeManagerAuthorizationStatus(rawValue: 5) {
            delegate?.didUpdateHomes(home: manager.homes)
        }
    }
}

extension HMAccessory {
    func findCharacteristic(type: String) -> HMCharacteristic? {
        for service in services {
            if let characteristic = service.characteristics.first(where: { $0.characteristicType == type }) {
                return characteristic
            }
        }
        return nil
    }
}
