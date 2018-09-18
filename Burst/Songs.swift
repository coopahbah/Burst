import Foundation

class Song {
    var name: String?
    var tempo: Double?
    var notes: [Int]?
    
    init(Name: String, Tempo: Double, Notes: [Int]) {
        name = Name
        tempo = Tempo
        notes = Notes
    }
}

let song1 = Song(Name: "Never Gonna Give You Up", Tempo: 80.0, Notes: [1, 2, 3, 1, 3, 4, 1, 4, 5, 6, 5, 4, 3])
