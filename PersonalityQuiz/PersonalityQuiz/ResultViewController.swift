//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Calvin Cantin on 18-09-29.
//  Copyright © 2018 Calvin Cantin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var responses: [Answer]!
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResults()

        // Do any additional setup after loading the view.
    }
    func calculatePersonalityResults()
    {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseType = responses.map{$0.type}
        for response in responseType
        {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1,pair2) -> Bool in return pair1.value > pair2.value})
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
