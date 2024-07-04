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
}

let allMission: [MissionDetail] = [
    MissionDetail(
        order: "1st",
        name: "Agility Skills",
        description: "Restore the lighting and demonstrate your ability to maintain stability under pressure.",
        tagline: "STABIL1TY IS A MUST-HAVE SKILL FOR EVERY SECRET AGENT.",
        objective: "Regain control of the **lighting power** system.",
        clue: ""
    ),
    MissionDetail(
        order: "2nd",
        name: "Tolerance Skills",
        description: "Embrace the unique qualities in you and others. Recognize how unity can be achieved through diversity.",
        tagline: "UNIQUENE5S IS A KEY VALUE FOR CREATING UNITY IN DIVERSITY",
        objective: "Find the **common ground**.",
        clue: ""
    ),
    MissionDetail(
        order: "3rd",
        name: "Collaboration Skills",
        description: "Unleash your team's synergy. Together, you will learn to move as one, executing with precision and grace. ",
        tagline: "TRAIN YOUR ALIGNMENT FOR V1CTORY",
        objective: "Work in **perfect harmony** and **coordination**.",
        clue: ""
    ),
    MissionDetail(
        order: "4th",
        name: "Observation Skills",
        description: "Your ability to notice and interpret subtle details will be the greatest asset as future secret agents.",
        tagline: "SECRET AGENTS MUST STAY ALERT AND ATTENTIVE T0 DETAILS.",
        objective: "Decode the **door lock** and **escape** the room!",
        clue: ""
    ),
]
