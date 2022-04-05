import UIKit
import SnapKit

class OverviewView: UIView{
    
    var mainText: UIView!
    var persons: UIView!
    
    var mainTextTitle: UILabel!
    var mainTextText: UILabel!
    
    var personsStackView: UIStackView!
    var personsRow1: UIStackView!
    var personsRow2: UIStackView!
    
    var person1: PersonView!
    var person2: PersonView!
    var person3: PersonView!
    var person4: PersonView!
    var person5: PersonView!
    var person6: PersonView!
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainText = UIView()
        persons = UIView()
        mainTextTitle = UILabel()
        mainTextText = UILabel()
        
        mainTextTitle.text = "Overview"
        mainTextTitle.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        mainTextText.text = "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."
        mainTextText.font = UIFont.systemFont(ofSize: 15)
        mainTextText.lineBreakMode = .byWordWrapping
        mainTextText.numberOfLines = 0
        
        addSubview(mainText)
        addSubview(persons)
        mainText.addSubview(mainTextTitle)
        mainText.addSubview(mainTextText)
        
        personsStackView = UIStackView()
        personsStackView.axis = .vertical
        personsStackView.spacing = 10
        
        person1 = PersonView(name: "Jon Landau", role: "Producer")
        person2 = PersonView(name: "Mauro Fiore", role: "Cinematographer")
        person3 = PersonView(name: "James Cameron", role: "Director")
        person4 = PersonView(name: "James Horner", role: "Composer")
        person5 = PersonView(name: "John Refoua", role: "Editor")
        person6 = PersonView(name: "James Cameron", role: "Producer")
        
        
        personsRow1 = UIStackView()
        personsRow1.axis = .horizontal
        personsRow1.alignment = .fill
        personsRow1.distribution = .fillEqually
        personsRow1.spacing = 5
        personsRow1.addArrangedSubview(person1)
        personsRow1.addArrangedSubview(person2)
        personsRow1.addArrangedSubview(person3)
        
        personsRow2 = UIStackView()
        personsRow2.axis = .horizontal
        personsRow2.alignment = .fill
        personsRow2.distribution = .fillEqually
        personsRow2.spacing = 5
        personsRow2.addArrangedSubview(person4)
        personsRow2.addArrangedSubview(person5)
        personsRow2.addArrangedSubview(person6)
        
        personsStackView.addArrangedSubview(personsRow1)
        personsStackView.addArrangedSubview(personsRow2)
        
        persons.addSubview(personsStackView)

    }
    
    func addConstraints(){
        mainText.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        persons.snp.makeConstraints{
            //mainText.backgroundColor = .yellow
            //persons.backgroundColor = .blue
            $0.width.equalToSuperview()
            $0.top.equalTo(mainText.snp.bottom)
        }
        
        mainTextTitle.snp.makeConstraints{
            $0.top.equalTo(mainText).offset(20)
            $0.leading.equalTo(mainText).offset(23)
            $0.trailing.equalTo(mainText.snp.trailing).offset(-10)
            $0.height.equalTo(mainText).dividedBy(6)
        }
        
        mainTextText.snp.makeConstraints{
            $0.top.equalTo(mainTextTitle.snp.bottom).offset(10)
            $0.leading.equalTo(mainText).offset(20)
            $0.trailing.equalTo(mainText.snp.trailing).offset(-10)
        }
        
        personsStackView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        
        personsRow1.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        personsRow2.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
    }
}
