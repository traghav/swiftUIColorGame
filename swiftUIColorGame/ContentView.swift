//
//  ContentView.swift
//  swiftUIColorGame
//
//  Created by rtoshniwal on 4/4/20.
//  Copyright © 2020 support. All rights reserved.
//

import SwiftUI
import UIKit
import AudioToolbox
struct ContentView: View {
    @State private var D:Double = 40
    @State public var winner:Int
    @State private var score:Int = 0
    @State public var mainColor:Array<Double>
    @State public var tileColors:Array<Array<Double>>
    func t2() -> Void {
        print("aaaaaaaaa")
        
        
    }
    func mutateRandomly(n: Double, variance: Double) -> Double {
        let mutateFraction = Double.random(in: 0...variance)
        let addOrNot = Bool.random()
        if(addOrNot == true) {
            return n+mutateFraction
        }
        else{
            return n-mutateFraction
        }
    }
    func randomColorMutator(OGcolor: Array<Double>, variance: Double) -> Array<Double> {
        //variance defines the amount by which the colour should vary in percentage
        let newRed = self.mutateRandomly(n: OGcolor[0], variance: variance)
        let newBlue = self.mutateRandomly(n: OGcolor[1], variance: variance)
        let newGreen = self.mutateRandomly(n: OGcolor[2], variance: variance)
        return [newRed, newBlue, newGreen]
    }
    
    func randomColorGenerator()->Array<Double> {
        return [Double.random(in: 0...255), Double.random(in: 0...255), Double.random(in: 0...255)]
    }
    
    func setWinnerTile() {
        self.winner = Int.random(in: 0..<4)
    }
    func setBoard() {
        self.setWinnerTile()
        self.mainColor = self.randomColorGenerator()
        for index in (0...3) {
            if(index != self.winner) {
                tileColors[index] = self.randomColorMutator(OGcolor: mainColor, variance: D)
            }
        }
        self.tileColors[self.winner]=self.mainColor
        print(winner)
        print(mainColor)
        print(score)
        print(tileColors)
        print(D)
    }
    func evaluate(pressed: Int) {
        if(pressed == self.winner) {
            self.score = self.score + 1
            self.setBoard()
        }
        else {
            self.score = 0
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            self.setBoard()
        }
    }
    
    
    var body: some View {
        VStack{
            Text("Color Picker Game").font(.largeTitle)
            Spacer()
            Text("Score: "+String(self.score)).bold()
            Rectangle()
            .fill(Color(red: self.mainColor[0] / 255, green: self.mainColor[2] / 255, blue: self.mainColor[1] / 255))
            .frame(width: 200, height: 200)
            .cornerRadius(10)
            HStack{
                Button(action: {
                    // What to perform
                    self.evaluate(pressed: 0)
                }) {
                    // How the button looks like
                    Rectangle()
                        .fill(Color(red: self.tileColors[0][0] / 255, green: self.tileColors[0][2] / 255, blue: self.tileColors[0][1] / 255))
                        .frame(width:95, height: 95)
                        .cornerRadius(10)

                }
                Button(action: {
                    // What to perform
                    self.evaluate(pressed: 1)
                }) {
                    // How the button looks like
                    Rectangle()
                        .fill(Color(red: self.tileColors[1][0] / 255, green: self.tileColors[1][2] / 255, blue: self.tileColors[1][1] / 255))
                        .frame(width:95, height: 95)
                        .cornerRadius(10)

                }
                               
            }
            HStack{
                Button(action: {
                    // What to perform
                    self.evaluate(pressed: 2)
                }) {
                    // How the button looks like
                    Rectangle()
                        .fill(Color(red: self.tileColors[2][0] / 255, green: self.tileColors[2][2] / 255, blue: self.tileColors[2][1] / 255))
                        .frame(width:95, height: 95)
                        .cornerRadius(10)

                }
                Button(action: {
                    // What to perform
                    self.evaluate(pressed: 3)
                }) {
                    // How the button looks like
                    Rectangle()
                        .fill(Color(red: self.tileColors[3][0] / 255, green: self.tileColors[3][2] / 255, blue: self.tileColors[3][1] / 255))
                        .frame(width:95, height: 95)
                        .cornerRadius(10)

                }
                               
            }
            Spacer()
            Text("Difficulty Level").padding(.bottom, 20).font(.title)
            HStack {
                Text("Harder").padding(.leading, 100)
                Spacer()
                Text("Easier").padding(.trailing, 100)
            }
            Slider(value: ($D), in: 5...60, step: 1).accentColor(Color(red: self.mainColor[0] / 255, green: self.mainColor[2] / 255, blue: self.mainColor[1] / 255)).padding(.leading, 100).padding(.trailing, 100)
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(winner: 2, mainColor: [0,0,0], tileColors: [[0,0,0],[0,0,0],[0,0,0],[0,0,0]])
    }
}
