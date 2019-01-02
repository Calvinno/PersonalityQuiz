//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Calvin Cantin on 18-09-29.
//  Copyright © 2018 Calvin Cantin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender
        {
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case singleButton3:
            answerChosen.append(currentAnswers[2])
        case singleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn
        {
            answerChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn
        {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn
        {
            answerChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn
        {
            answerChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBAction func rangedAnswerButtonTapped() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions:[Question] = []
    var answerChosen:[Answer] = []
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = createQuestionArray()
        updateUI()

        // Do any additional setup after loading the view.
    }
    func nextQuestion()
    {
        questionIndex += 1
        questionIndex < questions.count ? updateUI() : performSegue(withIdentifier: "ResultsSegue", sender: nil)
    }
    func updateUI()
    {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex)/Float(questions.count)
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type
        {
        case .single:
            updateSingleStack(using: currentAnswers)
            
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
    }
    func updateSingleStack(using answer: [Answer])
    {
        singleStackView.isHidden = false
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    func updateMultipleStack(using answer: [Answer])
    {
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        multipleStackView.isHidden = false
        multipleLabel1.text = answer[0].text
        multipleLabel2.text = answer[1].text
        multipleLabel3.text = answer[2].text
        multipleLabel4.text = answer[3].text
    }
    func updateRangedStack(using answer: [Answer])
    {
        rangedStackView.isHidden = false
        
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answer.first?.text
        rangedLabel2.text = answer.last?.text
    }
    func createQuestionArray() -> [Question]
    {
        var newArray:[Question] = []
        
        let question1 = Question(text: "Witch food do you like the most?", type: .single, answers: [
            Answer(text: "Steak", type: .dog),
            Answer(text: "Fish", type: .cat),
            Answer(text: "Carrots", type: .rabbit),
            Answer(text: "Corn", type: .turtle)])
        let question2 = Question(text: "Witch activities do you enjoy?", type: .multiple, answers: [
            Answer(text: "Swimming", type: .turtle),
            Answer(text: "Sleeping", type: .cat),
            Answer(text: "Cuddling", type: .rabbit),
            Answer(text: "Eating", type: .dog)])
        let question3 = Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [
            Answer(text: "I dislike them", type: .cat),
            Answer(text: "I get a little nervous", type: .rabbit),
            Answer(text: "I barely notice them", type: .turtle),
            Answer(text: "I like them", type: .dog)])
        newArray.append(question1)
        newArray.append(question2)
        newArray.append(question3)
        
        return newArray
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ResultsSegue" else {return}
        let resultsViewcontroller = segue.destination as! ResultViewController
        resultsViewcontroller.responses = answerChosen
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
