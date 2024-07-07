//
//  MissionDetail.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import Foundation

struct MissionDetail: Codable, Hashable {
    let order: String
    let name: String
    let description: String
    let tagline: String
    let objective: String
    let clue: String
    let missionSuccess: String
    let missionFailed: String
}

let allMission: [MissionDetail] = [
    MissionDetail(
        order: "1st",
        name: "Agility Skills",
        description: "Restore the lighting and demonstrate your ability to maintain stability under pressure.",
        tagline: "STABIL1TY IS A MUST-HAVE SKILL FOR EVERY SECRET AGENT.",
        objective: "_Objective:_ Regain control of the **lighting power** system.",
        clue: "A balanced approach might shed some light.",
        missionSuccess: "Excellent work! The lighting power system has been restored.",
        missionFailed: "Mission failed! Lighting power system remains uncontrolled."
    ),
    MissionDetail(
        order: "2nd",
        name: "Tolerance Skills",
        description: "The test system has regained control of the lighting power, but it's unstable. Find a way to stabilize the lighting power system and make it work normally.",
        tagline: "UNIQUENE5S IS A KEY VALUE FOR CREATING UNITY IN DIVERSITY",
        objective: "_Objective:_ Find the **common ground** and **switch the lamp** back to normal.",
        clue: "Unity forms where boundaries meet.",
        missionSuccess: "Excellent job! You have found the common ground.",
        missionFailed: "Mission failed! You were unable to find the common ground."
    ),
    MissionDetail(
        order: "3rd",
        name: "Collaboration Skills",
        description: "The test system takes out the power supply. You need to find a way to restore the power supply. As it is important for the test to continue.",
        tagline: "TUR8ULENCE OFTEN MEANS YOU’RE CLOSE TO SOMETHING BIG",
        objective: "_Objective:_ Work in **precise coordination** to regain control of the **Power Supply** system.",
        clue: "It’s all about patience and precision.",
        missionSuccess: "Excellent move! You’ve maintained precise coordination.",
        missionFailed: "Mission failed! Your team was faild to regain control of the Power Supply system."
    ),
    MissionDetail(
        order: "4th",
        name: "Observation Skills",
        description: "Power supply has been restored. Now, let’s test your ability to notice and interpret subtle details. It will be the greatest asset as future secret agents.",
        tagline: "SECRET AGENTS MUST STAY ALERT AND ATTENTIVE TO DETAILS.",
        objective: "_0bjective:_ Decode the **door lock** and **escape** the room!",
        clue: "Recall, reflect, and share! Even the tiniest detail matters.",
        missionSuccess: "Codes confirmed! You’ve proven your worth to be our agent.",
        missionFailed: "Codes denied! You failed this time, but we encourage you to try again."
    ),
]
