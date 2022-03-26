import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    var backgroundColor: UIColor
    
    var mainInfoView: UIView
    var mainInfoScore: UIView
    var mainInfoText: UIView
    
    var mainInfoBgImage: UIImageView
    
    var mainInfoScorePercentage: UILabel
    var mainInfoScoreText: UILabel
    
    var mainInfoTextTitle: UILabel
    var mainInfoTextTitleYear: UILabel
    var mainInfoTextDate: UILabel
    var mainInfoTextGenre: UILabel
    var mainInfoTextDuration: UILabel
    
    var mainInfoStar: UIImageView
    
    //var scoreLabel: UILabel
    
    var overviewView: UIView
    var overviewMainText: UIView
    var overviewPersons: UIView
    
    var overviewMainTextTitle: UILabel
    var overviewMainTextText: UILabel
    
    var overviewPersonsContainer: UIView
    var overviewPerson1: UIView
    var overviewPerson2: UIView
    var overviewPerson3: UIView
    var overviewPerson4: UIView
    var overviewPerson5: UIView
    var overviewPerson6: UIView
    
    var person1Name: UILabel
    var person1Role: UILabel
    var person2Name: UILabel
    var person2Role: UILabel
    var person3Name: UILabel
    var person3Role: UILabel
    var person4Name: UILabel
    var person4Role: UILabel
    var person5Name: UILabel
    var person5Role: UILabel
    var person6Name: UILabel
    var person6Role: UILabel
    
    init(backgroundColor: UIColor){
        self.backgroundColor = backgroundColor
        self.mainInfoView = UIView()
        self.mainInfoBgImage = UIImageView(image: UIImage(named: "avatar.jpeg"))
        self.mainInfoScore = UIView()
        self.mainInfoText = UIView()
        self.mainInfoScorePercentage = UILabel()
        self.mainInfoScore = UILabel()
        self.mainInfoScoreText = UILabel()
        self.mainInfoTextTitle = UILabel()
        self.mainInfoTextTitleYear = UILabel()
        self.mainInfoTextDate = UILabel()
        self.mainInfoTextGenre = UILabel()
        self.mainInfoTextDuration = UILabel()
        self.mainInfoStar = UIImageView(image: UIImage(named: "star"))
        
        self.overviewView = UIView()
        self.overviewMainText = UIView()
        self.overviewPersons = UIView()
        self.overviewPersonsContainer = UIView()
        self.overviewPerson1 = UIView()
        self.overviewPerson2 = UIView()
        self.overviewPerson3 = UIView()
        self.overviewPerson4 = UIView()
        self.overviewPerson5 = UIView()
        self.overviewPerson6 = UIView()
        
        self.overviewMainTextTitle = UILabel()
        self.overviewMainTextText = UILabel()
        self.person1Name = UILabel()
        self.person2Name = UILabel()
        self.person3Name = UILabel()
        self.person4Name = UILabel()
        self.person5Name = UILabel()
        self.person6Name = UILabel()
        self.person1Role = UILabel()
        self.person2Role = UILabel()
        self.person3Role = UILabel()
        self.person4Role = UILabel()
        self.person5Role = UILabel()
        self.person6Role = UILabel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    convenience init(){
        self.init(backgroundColor: .white)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }
    
    private func buildViews(){
        self.view.backgroundColor = .white

        
        
        self.view.addSubview(mainInfoView)
        self.view.addSubview(overviewView)
        
        //  Main info
        mainInfoBgImage.contentMode = .scaleAspectFill
        mainInfoBgImage.clipsToBounds = true
        mainInfoView.addSubview(mainInfoBgImage)
        
        mainInfoView.addSubview(mainInfoScore)
        mainInfoView.addSubview(mainInfoText)
                
        mainInfoScorePercentage.text = "76%"
        mainInfoScorePercentage.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        mainInfoScoreText.text = "User Score"
        mainInfoScoreText.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        mainInfoTextTitle.text = "Avatar"
        mainInfoTextTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        mainInfoTextTitleYear.text = "(2009)"
        mainInfoTextTitleYear.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        mainInfoTextDate.text = "18/12/2009 (US)"
        mainInfoTextDate.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        mainInfoTextGenre.text = "Adventure, Action, Fantasy, Sci-fi"
        mainInfoTextGenre.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        mainInfoTextDuration.text = "2h 42m"
        mainInfoTextDuration.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        mainInfoScorePercentage.textColor = .white
        mainInfoScoreText.textColor = .white
        mainInfoTextTitle.textColor = .white
        mainInfoTextTitleYear.textColor = .white
        mainInfoTextDate.textColor = .white
        mainInfoTextGenre.textColor = .white
        mainInfoTextDuration.textColor = .white
        
        mainInfoScore.addSubview(mainInfoScorePercentage)
        mainInfoScore.addSubview(mainInfoScoreText)
        
        mainInfoText.addSubview(mainInfoTextTitle)
        mainInfoText.addSubview(mainInfoTextTitleYear)
        mainInfoText.addSubview(mainInfoTextDate)
        mainInfoText.addSubview(mainInfoTextGenre)
        mainInfoText.addSubview(mainInfoTextDuration)
        
        mainInfoText.addSubview(mainInfoStar)

        //  Overview
        overviewView.addSubview(overviewMainText)
        overviewView.addSubview(overviewPersons)
        
        overviewMainTextTitle.text = "Overview"
        overviewMainTextTitle.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        overviewMainTextText.text = "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."
        overviewMainTextText.font = UIFont.systemFont(ofSize: 15)
        overviewMainTextText.lineBreakMode = .byWordWrapping
        overviewMainTextText.numberOfLines = 0
        
        overviewMainText.addSubview(overviewMainTextTitle)
        overviewMainText.addSubview(overviewMainTextText)
        
        buildViewsPersons()
        
    }
    

    
    private func buildViewsPersons(){
        overviewPersons.addSubview(overviewPersonsContainer)
        overviewPersonsContainer.addSubview(overviewPerson1)
        overviewPersonsContainer.addSubview(overviewPerson2)
        overviewPersonsContainer.addSubview(overviewPerson3)
        overviewPersonsContainer.addSubview(overviewPerson4)
        overviewPersonsContainer.addSubview(overviewPerson5)
        overviewPersonsContainer.addSubview(overviewPerson6)
        
        person1Name.text = "Jon Landau"
        person1Role.text = "Producer"
        person2Name.text = "Mauro Fiore"
        person2Role.text = "Cinematographer"
        person3Name.text = "James Cameron"
        person3Role.text = "Director"
        
        person4Name.text = "James Horner"
        person4Role.text = "Composer"
        person5Name.text = "John Refoua"
        person5Role.text = "Editor"
        person6Name.text = "James Cameron"
        person6Role.text = "Producer"
        
        
        
        person1Name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        person2Name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        person3Name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        person4Name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        person5Name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        person6Name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        
        person1Role.font = UIFont.systemFont(ofSize: 14)
        person2Role.font = UIFont.systemFont(ofSize: 14)
        person3Role.font = UIFont.systemFont(ofSize: 14)
        person4Role.font = UIFont.systemFont(ofSize: 14)
        person5Role.font = UIFont.systemFont(ofSize: 14)
        person6Role.font = UIFont.systemFont(ofSize: 14)
                
        overviewPerson1.addSubview(person1Name)
        overviewPerson1.addSubview(person1Role)
        overviewPerson2.addSubview(person2Name)
        overviewPerson2.addSubview(person2Role)
        overviewPerson3.addSubview(person3Name)
        overviewPerson3.addSubview(person3Role)
        overviewPerson4.addSubview(person4Name)
        overviewPerson4.addSubview(person4Role)
        overviewPerson5.addSubview(person5Name)
        overviewPerson5.addSubview(person5Role)
        overviewPerson6.addSubview(person6Name)
        overviewPerson6.addSubview(person6Role)
    }
    
    private func addConstraints(){
        mainInfoView.snp.makeConstraints {
            $0.leading.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view.safeAreaLayoutGuide).dividedBy(2)

        }
        
        mainInfoBgImage.snp.makeConstraints{
            $0.top.bottom.trailing.leading.equalTo(mainInfoView)
            

        }
        
        mainInfoScore.snp.makeConstraints{
            $0.top.equalTo(mainInfoView.snp.top)
            $0.width.equalTo(mainInfoView.snp.width)
            $0.height.equalTo(mainInfoView.snp.height).dividedBy(2)
        }
        
        mainInfoScorePercentage.snp.makeConstraints{
            $0.leading.equalTo(mainInfoScore.snp.leading).offset(30)
            $0.bottom.equalTo(mainInfoScore.snp.bottom)
        }
        
        mainInfoScoreText.snp.makeConstraints{
            $0.bottom.equalTo(mainInfoScorePercentage.snp.bottom).offset(-2)
            $0.leading.equalTo(mainInfoScorePercentage.snp.trailing).offset(20)
        }
        
        //
        mainInfoText.snp.makeConstraints{
            $0.width.equalTo(mainInfoView.snp.width)
            $0.height.equalTo(mainInfoView.snp.height).dividedBy(2)
            $0.top.equalTo(mainInfoScore.snp.bottom)
        }
        
        mainInfoTextTitle.snp.makeConstraints{
            $0.top.equalTo(mainInfoText.snp.top).offset(25)
            $0.left.equalTo(mainInfoText.snp.left).offset(20)
        }
        
        mainInfoTextTitleYear.snp.makeConstraints{
            $0.top.equalTo(mainInfoTextTitle.snp.top)
            $0.leading.equalTo(mainInfoTextTitle.snp.trailing).offset(10)
        }
        
        mainInfoTextDate.snp.makeConstraints{
            $0.top.equalTo(mainInfoTextTitle.snp.bottom).offset(10)
            $0.leading.equalTo(mainInfoTextTitle.snp.leading)
        }
        
        mainInfoTextGenre.snp.makeConstraints{
            $0.top.equalTo(mainInfoTextDate.snp.bottom).offset(5)
            $0.leading.equalTo(mainInfoTextTitle.snp.leading)
        }
        
        mainInfoTextDuration.snp.makeConstraints{
            $0.top.equalTo(mainInfoTextGenre.snp.top)
            $0.leading.equalTo(mainInfoTextGenre.snp.trailing).offset(10)
        }
        
        mainInfoStar.snp.makeConstraints{
            $0.top.equalTo(mainInfoTextGenre.snp.bottom).offset(30)
            $0.leading.equalTo(mainInfoTextGenre.snp.leading)
            $0.width.equalTo(35)
            $0.height.equalTo(35)
        }
        
        
        
        //  Overview
        overviewView.snp.makeConstraints{
            $0.top.equalTo(mainInfoView.snp.bottom)
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view.safeAreaLayoutGuide).dividedBy(2)
        }
        
        overviewMainText.snp.makeConstraints{
            //$0.height.equalTo(overviewView).dividedBy(2)
            $0.width.equalTo(overviewView)
        }
        
        overviewPersons.snp.makeConstraints{
            $0.height.equalTo(overviewView).dividedBy(2)
            $0.width.equalTo(overviewView)
            $0.top.equalTo(overviewMainText.snp.bottom)
        }
        
        overviewMainTextTitle.snp.makeConstraints{
            $0.top.equalTo(overviewMainText).offset(20)
            $0.leading.equalTo(overviewMainText).offset(20)
            $0.trailing.equalTo(overviewMainText.snp.trailing).offset(-10)
            $0.height.equalTo(overviewMainText).dividedBy(6)
        }
        
        overviewMainTextText.snp.makeConstraints{
            $0.top.equalTo(overviewMainTextTitle.snp.bottom).offset(10)
            $0.leading.equalTo(overviewMainText).offset(20)
            $0.trailing.equalTo(overviewMainText.snp.trailing).offset(-10)
        }
        
        
        addConstraintsForPersons()
         
    }
    
    private func addConstraintsForPersons(){
            overviewPersonsContainer.snp.makeConstraints{
                $0.top.equalTo(overviewPersons.snp.top).offset(10)
                $0.height.equalTo(overviewPersons)
                $0.leading.equalTo(overviewPersons.snp.leading).offset(20)
                $0.trailing.equalTo(overviewPersons.snp.trailing).offset(-20)
            }
            
            overviewPerson1.snp.makeConstraints{
                $0.top.equalTo(overviewPersonsContainer.snp.top)
                $0.leading.equalTo(overviewPersonsContainer.snp.leading)
                $0.width.equalTo(overviewPersonsContainer).dividedBy(3)
                $0.height.equalTo(overviewPersonsContainer).dividedBy(3)
            }
            person1Name.snp.makeConstraints{
                $0.height.equalTo(overviewPerson1).dividedBy(3)
                $0.width.equalTo(overviewPerson1)
            }
            person1Role.snp.makeConstraints{
                $0.height.equalTo(overviewPerson1).dividedBy(3)
                $0.width.equalTo(overviewPerson1)
                $0.top.equalTo(person1Name.snp.bottom)
            }
            
            overviewPerson2.snp.makeConstraints{
                $0.top.equalTo(overviewPersonsContainer.snp.top)
                $0.leading.equalTo(overviewPerson1.snp.trailing)
                $0.width.equalTo(overviewPersonsContainer).dividedBy(3)
                $0.height.equalTo(overviewPersonsContainer).dividedBy(3)
            }
            person2Name.snp.makeConstraints{
                $0.height.equalTo(overviewPerson2).dividedBy(3)
                $0.width.equalTo(overviewPerson2)
            }
            person2Role.snp.makeConstraints{
                $0.height.equalTo(overviewPerson2).dividedBy(3)
                $0.width.equalTo(overviewPerson2)
                $0.top.equalTo(person2Name.snp.bottom)
            }
            
            overviewPerson3.snp.makeConstraints{
                $0.top.equalTo(overviewPersonsContainer.snp.top)
                $0.leading.equalTo(overviewPerson2.snp.trailing)
                $0.width.equalTo(overviewPersonsContainer).dividedBy(3)
                $0.height.equalTo(overviewPersonsContainer).dividedBy(3)
            }
            person3Name.snp.makeConstraints{
                $0.height.equalTo(overviewPerson3).dividedBy(3)
                $0.width.equalTo(overviewPerson3)
            }
            person3Role.snp.makeConstraints{
                $0.height.equalTo(overviewPerson3).dividedBy(3)
                $0.width.equalTo(overviewPerson3)
                $0.top.equalTo(person3Name.snp.bottom)
            }
            
            overviewPerson4.snp.makeConstraints{
                $0.top.equalTo(overviewPerson1.snp.bottom)
                $0.leading.equalTo(overviewPersonsContainer.snp.leading)
                $0.width.equalTo(overviewPersonsContainer).dividedBy(3)
                $0.height.equalTo(overviewPersonsContainer).dividedBy(3)
            }
            person4Name.snp.makeConstraints{
                $0.height.equalTo(overviewPerson4).dividedBy(3)
                $0.width.equalTo(overviewPerson4)
            }
            person4Role.snp.makeConstraints{
                $0.height.equalTo(overviewPerson4).dividedBy(3)
                $0.width.equalTo(overviewPerson4)
                $0.top.equalTo(person4Name.snp.bottom)
            }
            
            overviewPerson5.snp.makeConstraints{
                $0.top.equalTo(overviewPerson1.snp.bottom)
                $0.leading.equalTo(overviewPerson4.snp.trailing)
                $0.width.equalTo(overviewPersonsContainer).dividedBy(3)
                $0.height.equalTo(overviewPersonsContainer).dividedBy(3)
            }
            person5Name.snp.makeConstraints{
                $0.height.equalTo(overviewPerson5).dividedBy(3)
                $0.width.equalTo(overviewPerson5)
            }
            person5Role.snp.makeConstraints{
                $0.height.equalTo(overviewPerson5).dividedBy(3)
                $0.width.equalTo(overviewPerson5)
                $0.top.equalTo(person5Name.snp.bottom)
            }
            
            overviewPerson6.snp.makeConstraints{
                $0.top.equalTo(overviewPerson1.snp.bottom)
                $0.leading.equalTo(overviewPerson5.snp.trailing)
                $0.width.equalTo(overviewPersonsContainer).dividedBy(3)
                $0.height.equalTo(overviewPersonsContainer).dividedBy(3)
            }
            person6Name.snp.makeConstraints{
                $0.height.equalTo(overviewPerson6).dividedBy(3)
                $0.width.equalTo(overviewPerson6)
            }
            person6Role.snp.makeConstraints{
                $0.height.equalTo(overviewPerson6).dividedBy(3)
                $0.width.equalTo(overviewPerson6)
                $0.top.equalTo(person6Name.snp.bottom)
            }
        }    
    }
