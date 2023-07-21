//
//  MainSearchViewController.swift
//  WordsFactory
//
//  Created by SHREDDING on 12.07.2023.
//

import UIKit
import AVFoundation

class MainSearchViewController: UIViewController {
    
    // MARK: - my Variables
    
    let apiManagerDictionary = ApiManagerDictionary()
    
    var currentWord: Word? {
        didSet {
            if currentWord != nil{
                self.emptyLabel.layer.opacity = 0
                self.partOfSpeechLabel.layer.opacity = 1
                self.speakButton.layer.opacity = 1
            }else{
                self.emptyLabel.layer.opacity = 1
                self.partOfSpeechLabel.layer.opacity = 0
                self.speakButton.layer.opacity = 0
            }
            
            self.addToDictionaryButton.layer.opacity = CoreWordService.wordIsAlreadySaved(word: currentWord) == true ? 0 : 1
            
            self.meaningTableViewBottomConstraint.constant = CoreWordService.wordIsAlreadySaved(word: currentWord) == true ? -10 : -70
            
        }
    }
    
    func setInfo(word: Word?) {
        self.currentWord = word
        
        self.setAttributtedWord(self.wordLabel, word: word?.word ?? "", currentWord?.transcription ?? "", .systemPink)
        
        self.setAttributtedWord(self.partOfSpeechLabel, word: "Part Of Speech", currentWord?.PartOfSpeech ?? "", .black)
        
        
        self.meaningTableView.reloadData()
    }
    
    // MARK: - SEARCH OBJECTS
    
    let searchView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        view.layer.cornerRadius = 20
        
        let searchImageView = UIImageView()
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.image = UIImage(named: "SearchIcon")
        searchImageView.backgroundColor = .clear
        
        view.addSubview(searchImageView)
        NSLayoutConstraint.activate([
            searchImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ])
        
        
        return view
    }()
    
    
    let searchTextField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Search..."
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    // MARK: - WORD RESULT OBJECTS
    
    let wordLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.numberOfLines = 0
        
        
        
        return label
    }()
    
    let speakButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "speak"), for: .normal)
        button.layer.opacity = 0
        
        return button
    }()
    
    let partOfSpeechLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Table View
    
    let meaningTableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
                
        let cellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SearchTableViewCell")
        
        return tableView
    }()
    
    var meaningTableViewBottomConstraint:NSLayoutConstraint!
    
    
    // MARK: - empty Label
    
    let emptyLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Not Found"
        label.numberOfLines = 0
        
        label.textAlignment = .center
        
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        
        return label
    }()
    
    let addToDictionaryButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .orange
        configuration.cornerStyle = .large
        button.configuration = configuration
        button.tintColor = .white
        
        button.setTitle("Add to Dictionary", for: .normal)
        
        button.layer.opacity = 0
        
        button.layer.shadowColor = UIColor.orange.cgColor
        
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 5
                
        return button
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        
        self.configureSearch()
        
        self.configureWordResult()
        
        self.configureEmptyLabel()
        
        self.configureAddToDictionaryButton()
        
        
    }
    
    // MARK: - Add subviews
    
    private func addSubviews(){
        self.view.addSubview(self.searchView)
        self.searchView.addSubview(self.searchTextField)
        
        self.view.addSubview(self.wordLabel)
        self.view.addSubview(self.speakButton)
        self.view.addSubview(self.partOfSpeechLabel)
        self.view.addSubview(self.meaningTableView)
        self.view.addSubview(self.emptyLabel)
        
        self.view.addSubview(self.addToDictionaryButton)
    }
    // MARK: - Configure Search View
    
    private func configureSearch(){
        
        // configuration searchView
        NSLayoutConstraint.activate([
            self.searchView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.searchView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            self.searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 15),
            self.searchView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // configuration searchTextField
        self.searchTextField.delegate = self
        NSLayoutConstraint.activate([
            self.searchTextField.centerYAnchor.constraint(equalTo: self.searchView.centerYAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.searchView.leadingAnchor,constant: 20),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.searchView.trailingAnchor,constant: -50),
        ])
    }
    
    // MARK: - Configuration Word Result
    
    private func configureWordResult(){
        
        // word
        NSLayoutConstraint.activate([
            self.wordLabel.topAnchor.constraint(equalTo: self.searchView.bottomAnchor,constant: 30),
            self.wordLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        // button speak
        
        self.speakButton.addAction(UIAction(handler: { _ in
            if let wordSpeak = self.currentWord{
                let utterance = AVSpeechUtterance(string: wordSpeak.word)
                utterance.voice = AVSpeechSynthesisVoice(language: wordSpeak.language)
                utterance.rate = 0.1

                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
            
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.speakButton.centerYAnchor.constraint(equalTo: self.wordLabel.centerYAnchor),
            self.speakButton.leadingAnchor.constraint(equalTo: self.wordLabel.trailingAnchor,constant: 40),
            self.speakButton.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20)
        ])
        
        
        // part of speech
        NSLayoutConstraint.activate([
            self.partOfSpeechLabel.topAnchor.constraint(equalTo: self.wordLabel.bottomAnchor,constant: 30),
            self.partOfSpeechLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.partOfSpeechLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // meaning
        self.meaningTableView.delegate = self
        self.meaningTableView.dataSource = self
        
        self.meaningTableViewBottomConstraint = NSLayoutConstraint(item: self.meaningTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -70)
        
        NSLayoutConstraint.activate([
            self.meaningTableView.topAnchor.constraint(equalTo: self.partOfSpeechLabel.bottomAnchor, constant: 10),
            meaningTableViewBottomConstraint,
            self.meaningTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.meaningTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        
        
        self.addToDictionaryButton.addAction(UIAction(handler: { _ in
            CoreWordService.createCoreWord(word: self.currentWord)
            UIView.transition(with: self.meaningTableView, duration: 0.3, options: .transitionCrossDissolve) {
                self.meaningTableViewBottomConstraint.constant = -10
                self.addToDictionaryButton.layer.opacity = 0
            }
            
        }), for: .touchUpInside)
        
    }
    
    private func configureEmptyLabel(){
        NSLayoutConstraint.activate([
            self.emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.emptyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 15)
        ])
    }
    
    
    private func configureAddToDictionaryButton(){
        NSLayoutConstraint.activate([
            self.addToDictionaryButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            self.addToDictionaryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.addToDictionaryButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3 * 2),
            self.addToDictionaryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setAttributtedWord(_ label:UILabel,word:String,_ second:String, _ secondColor:UIColor){
        let word = NSMutableAttributedString(string: "\(word)    ", attributes: [.foregroundColor : UIColor.black,])
        
        let secondWord = NSAttributedString(string: "[\(second)]", attributes: [.foregroundColor : secondColor, .font: UIFont.systemFont(ofSize: 20, weight: .regular)])
        
        if !second.isEmpty{
            word.append(secondWord)
        }
        
        label.attributedText = word
    }
    
}

// MARK: - TextField Delegate
extension MainSearchViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        apiManagerDictionary.getWord(word: textField.text ?? "") { [weak self] word in
            word?.printWord()

            self?.setInfo(word: word)
        }
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - Table view Delegate
extension MainSearchViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentWord?.meaning.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        
        cell.wordLabel.text = self.currentWord?.meaning[indexPath.row].word ?? ""
        
        cell.speakButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.speakButton.addAction(UIAction(handler: { _ in
            print(indexPath.row)
            if let wordSpeak = self.currentWord?.meaning[indexPath.row]{
                let utterance = AVSpeechUtterance(string: wordSpeak.word)
                utterance.voice = AVSpeechSynthesisVoice(language: wordSpeak.language )
                utterance.rate = 0.1

                let synthesizer = AVSpeechSynthesizer()
                if !synthesizer.isSpeaking{
                    synthesizer.speak(utterance)
                }
            }
        }), for: .touchUpInside)
        
        return cell
        
    }
    
}


