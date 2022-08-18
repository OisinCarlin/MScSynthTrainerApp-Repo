//
//  QHost1.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 16/08/2022.
//

import SwiftUI


struct QHost1Data {
    
    var randomInt = Int.random(in: 1..<11)

}

class QHost1Conductor: ObservableObject{

    @EnvironmentObject var questionCount: QuestionCount

    @Published var data = QHost1Data() {
        
        didSet{
            
            
        }
        
    }
  
}

struct QHost1: View {

    @StateObject var conductor = QHost1Conductor()

  @EnvironmentObject var questionCount: QuestionCount
        

    var body: some View {

        if questionCount.count < 10 {
        if (self.conductor.data.randomInt == 1){
                q1()
        }
        if (self.conductor.data.randomInt == 2){
                q2()
        }
        if (self.conductor.data.randomInt == 3){
                q3()
        }
        if (self.conductor.data.randomInt == 4){
                q4()
        }
        if (self.conductor.data.randomInt == 5){
                q5()
        }
        if (self.conductor.data.randomInt == 6){
                q6()
        }
        if (self.conductor.data.randomInt == 7){
                q7()
        }
        if (self.conductor.data.randomInt == 8){
                q8()
        }
        if (self.conductor.data.randomInt == 9){
                q9()
        }
        if (self.conductor.data.randomInt == 10){
                q10()
        }
        } else {
            QuizSummary()
        }
            
    }
}

struct QHost1_Previews: PreviewProvider {
    static var previews: some View {
        QHost1()
    }
}
