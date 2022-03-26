import UIKit
import SnapKit

class OverviewView: UIView{
    
    var mainText: UIView
    var persons: UIView
    
    var mainTextTitle: UILabel
    var mainTextText: UILabel
    
    var personsContainer: UIView
    var person1: PersonView
    var person2: PersonView
    var person3: PersonView
    var person4: PersonView
    var person5: PersonView
    var person6: PersonView
    
    init(){
        mainText = UIView()
        persons = UIView()
        mainTextTitle = UILabel()
        mainTextText = UILabel()
        personsContainer = UIView()
        person1 = PersonView(name: "Jon Landau", role: "Producer")
        person2 = PersonView(name: "Mauro Fiore", role: "Cinematographer")
        person3 = PersonView(name: "James Cameron", role: "Director")
        person4 = PersonView(name: "James Horner", role: "Composer")
        person5 = PersonView(name: "John Refoua", role: "Editor")
        person6 = PersonView(name: "James Cameron", role: "Producer")
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        addSubview(mainText)
        addSubview(persons)
        
        mainTextTitle.text = "Overview"
        mainTextTitle.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        mainTextText.text = "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."
        mainTextText.font = UIFont.systemFont(ofSize: 15)
        mainTextText.lineBreakMode = .byWordWrapping
        mainTextText.numberOfLines = 0
        
        mainText.addSubview(mainTextTitle)
        mainText.addSubview(mainTextText)
        
        persons.addSubview(personsContainer)
        personsContainer.addSubview(person1)
        personsContainer.addSubview(person2)
        personsContainer.addSubview(person3)
        personsContainer.addSubview(person4)
        personsContainer.addSubview(person5)
        personsContainer.addSubview(person6)
    }
    
    func addConstraints(){
        mainText.snp.makeConstraints{
            //$0.height.equalTo(overviewView).dividedBy(2)
            $0.width.equalTo(self)
        }
                
        persons.snp.makeConstraints{
            $0.height.equalTo(self).dividedBy(2)
            $0.width.equalTo(self)
            $0.top.equalTo(mainText.snp.bottom)
        }
        
        mainTextTitle.snp.makeConstraints{
            $0.top.equalTo(mainText).offset(20)
            $0.leading.equalTo(mainText).offset(20)
            $0.trailing.equalTo(mainText.snp.trailing).offset(-10)
            $0.height.equalTo(mainText).dividedBy(6)
        }
        
        mainTextText.snp.makeConstraints{
            $0.top.equalTo(mainTextTitle.snp.bottom).offset(10)
            $0.leading.equalTo(mainText).offset(20)
            $0.trailing.equalTo(mainText.snp.trailing).offset(-10)
        }
        
        addConstraintsForPersons()
    }
    
    private func addConstraintsForPersons(){
            personsContainer.snp.makeConstraints{
                $0.top.equalTo(persons.snp.top).offset(10)
                $0.height.equalTo(persons)
                $0.leading.equalTo(persons.snp.leading).offset(20)
                $0.trailing.equalTo(persons.snp.trailing).offset(-20)
            }
            
            person1.snp.makeConstraints{
                $0.top.equalTo(personsContainer.snp.top)
                $0.leading.equalTo(personsContainer.snp.leading)
                $0.width.equalTo(personsContainer).dividedBy(3)
                $0.height.equalTo(personsContainer).dividedBy(3)
            }
            
            person2.snp.makeConstraints{
                $0.top.equalTo(personsContainer.snp.top)
                $0.leading.equalTo(person1.snp.trailing)
                $0.width.equalTo(personsContainer).dividedBy(3)
                $0.height.equalTo(personsContainer).dividedBy(3)
            }
            
            person3.snp.makeConstraints{
                $0.top.equalTo(personsContainer.snp.top)
                $0.leading.equalTo(person2.snp.trailing)
                $0.width.equalTo(personsContainer).dividedBy(3)
                $0.height.equalTo(personsContainer).dividedBy(3)
            }
            
            person4.snp.makeConstraints{
                $0.top.equalTo(person1.snp.bottom)
                $0.leading.equalTo(personsContainer.snp.leading)
                $0.width.equalTo(personsContainer).dividedBy(3)
                $0.height.equalTo(personsContainer).dividedBy(3)
            }
            
            person5.snp.makeConstraints{
                $0.top.equalTo(person1.snp.bottom)
                $0.leading.equalTo(person4.snp.trailing)
                $0.width.equalTo(personsContainer).dividedBy(3)
                $0.height.equalTo(personsContainer).dividedBy(3)
            }
            
            person6.snp.makeConstraints{
                $0.top.equalTo(person1.snp.bottom)
                $0.leading.equalTo(person5.snp.trailing)
                $0.width.equalTo(personsContainer).dividedBy(3)
                $0.height.equalTo(personsContainer).dividedBy(3)
            }
        }
}
