//
//  AwardManager.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 16/03/25.
//

import UIKit


class AwardManager {
    private var userModel = UserModel.shared
    private var awardModel = AwardBase.shared
    
    func checkAward() -> AwardManagerEnum?{
        print("checkAward")
        //first use
        if userModel.getQuizUsageTimeInMin() > 0 && userModel.getQuizUsageTimeInMin() < 5 && awardModel.isAwardGranted(.firstUsage) == false {
            awardModel.grantAward(.firstUsage)
            return .firstUsage
        }
        // ten Correct Answer
        else if userModel.getPoints() > 9 && userModel.getPoints() < 20 && awardModel.isAwardGranted(.tenCorrectAnswer) == false {
            awardModel.grantAward(.tenCorrectAnswer)
            return .tenCorrectAnswer
        }
        // 20 Correct Answer
        else if userModel.getPoints() > 19 && userModel.getPoints() < 30 && awardModel.isAwardGranted(.twentyCorrectAnswer) == false {
            awardModel.grantAward(.twentyCorrectAnswer)
            return .twentyCorrectAnswer
        }
        
        // 50 Correct Answer
        else if userModel.getPoints() > 49 && userModel.getPoints() < 100 && awardModel.isAwardGranted(.fiftyCorrectAnswer) == false {
            awardModel.grantAward(.fiftyCorrectAnswer)
            return .fiftyCorrectAnswer
        }
        
        // 100 Correct Answer
        else if userModel.getPoints() > 99 && awardModel.isAwardGranted(.hundredCorrectAnswer) == false {
            awardModel.grantAward(.hundredCorrectAnswer)
            return .hundredCorrectAnswer
        }
        
        // 5 minut in quiz
        else if userModel.getQuizUsageTimeInMin() > 5  && awardModel.isAwardGranted(.fiveMinInQuiz) == false {
            awardModel.grantAward(.fiveMinInQuiz)
            return .fiveMinInQuiz
        }
        
        // 10 minut in quiz
        else if userModel.getQuizUsageTimeInMin() > 10  && awardModel.isAwardGranted(.tenMinInQuiz) == false {
            awardModel.grantAward(.tenMinInQuiz)
            return .tenMinInQuiz
        }
        
        // 20 minut in quiz
        else if userModel.getQuizUsageTimeInMin() > 20  && awardModel.isAwardGranted(.twentyMinInQuiz) == false {
            awardModel.grantAward(.twentyMinInQuiz)
            return .twentyMinInQuiz
        }
        
        // 30 minut in quiz
        else if userModel.getQuizUsageTimeInMin() > 30  && awardModel.isAwardGranted(.halfHourInQuiz) == false {
            awardModel.grantAward(.halfHourInQuiz)
            return .halfHourInQuiz
        }
        
        // 60 minut in quiz
        else if userModel.getQuizUsageTimeInMin() > 60  && awardModel.isAwardGranted(.hourInQuiz) == false {
            awardModel.grantAward(.hourInQuiz)
            return .hourInQuiz
        }
        
        else {
            return nil
        }
    }
}
