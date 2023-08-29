//
//  ContentView.swift
//  YouAreAwsome
//
//  Created by Francesca MACDONALD on 2023-08-14.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var imageName = ""

    @State private var imageNumber = 0
    @State private var stringNumber = 0
    @State private var soundNumber = 0

    @State private var messageString: [String] = ["Cool!", "You are awesome", "Nice to meet you", "Lessss go", "Fun times", "That's all folks"]

    
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundName = ""
    @State private var soundIsOn = true
    
    var body: some View {
        
        VStack {
            
            Text(messageString[stringNumber])
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding()
                .animation(.easeInOut(duration: 0.15), value: imageNumber)

            

            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding()
                .animation(.default, value: imageNumber)
            
            Spacer()
                
            HStack {
                Text("Sound is \(soundIsOn ? "on" : "off")")
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) { newValue in
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }
                Spacer()
                Button("Show image") {
                    
                    imageNumber = nonRepeatingRandom(lastNumber: imageNumber, upperBounds: 10)
                    imageName = "image\(imageNumber)"
                    
                    stringNumber = nonRepeatingRandom(lastNumber: stringNumber, upperBounds: messageString.count-1)
                    
                    soundNumber = nonRepeatingRandom(lastNumber: soundNumber, upperBounds: 5)
                    soundName = "sound\(soundNumber)"
                    playSound(soundName: soundName)
                    
                }
                .buttonStyle(.borderedProminent)
            }
            .tint(.accentColor)
        }
        .padding()
    }
    func nonRepeatingRandom(lastNumber: Int, upperBounds: Int) -> Int {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 1...upperBounds)
        } while newNumber == lastNumber
        return newNumber
    }
 
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Could not read file named \(soundName)")
            return
        }
        if soundIsOn {
            do {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer.play()
            } catch {
                print("😡 Error: \(error.localizedDescription) creating audioPlayer")
            }
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
