import UIKit
import SnapKit

class MainInfoView: UIView{
    
    var bgImage: UIImageView!
    
    var scorePercentage: UILabel!
    var scoreText: UILabel!
    
    var textTitle: UILabel!
    var textTitleYear: UILabel!
    var textDate: UILabel!
    var textGenre: UILabel!
    var textDuration: UILabel!
    
    var starImage: UIImageView!
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        bgImage = UIImageView(image: UIImage(named: "avatar.jpeg"))
        scorePercentage = UILabel()
        scoreText = UILabel()
        textTitle = UILabel()
        textTitleYear = UILabel()
        textDate = UILabel()
        textGenre = UILabel()
        textDuration = UILabel()
        starImage = UIImageView(image: UIImage(named: "star"))
        
        bgImage.contentMode = .scaleAspectFill
        bgImage.clipsToBounds = true
        addSubview(bgImage)
                
        scorePercentage.text = "86%"
        scorePercentage.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        scoreText.text = "User Score"
        scoreText.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        textTitle.text = "Avatar"
        textTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textTitleYear.text = "(2009)"
        textTitleYear.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textDate.text = "18/12/2009 (US)"
        textDate.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textGenre.text = "Adventure, Action, Fantasy, Sci-fi"
        textGenre.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textDuration.text = "2h 42m"
        textDuration.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        scorePercentage.textColor = .white
        scoreText.textColor = .white
        textTitle.textColor = .white
        textTitleYear.textColor = .white
        textDate.textColor = .white
        textGenre.textColor = .white
        textDuration.textColor = .white
        
        addSubview(scorePercentage)
        addSubview(scoreText)
        
        addSubview(textTitle)
        addSubview(textTitleYear)
        addSubview(textDate)
        addSubview(textGenre)
        addSubview(textDuration)
        
        addSubview(starImage)
    }
    
    func addConstraints() {
        bgImage.snp.makeConstraints{
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
        
        
        scorePercentage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalTo(textTitle.snp.top).offset(-20)
        }
        
        scoreText.snp.makeConstraints{
            $0.bottom.equalTo(scorePercentage.snp.bottom).offset(-2)
            $0.leading.equalTo(scorePercentage.snp.trailing).offset(20)
        }
        
        //

        
        textTitle.snp.makeConstraints{
            $0.bottom.equalTo(textGenre.snp.top).offset(-35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        textTitleYear.snp.makeConstraints{
            $0.top.equalTo(textTitle.snp.top)
            $0.leading.equalTo(textTitle.snp.trailing).offset(8)
        }
        
        textDate.snp.makeConstraints{
            $0.bottom.equalTo(starImage.snp.top).offset(-40)
            $0.leading.equalTo(textTitle.snp.leading)
        }
        
        textGenre.snp.makeConstraints{
            $0.top.equalTo(textDate.snp.bottom).offset(5)
            $0.leading.equalTo(textTitle.snp.leading)
            //$0.bottom.equalTo(starImage.snp.top).offset(30)
        }
        
        textDuration.snp.makeConstraints{
            $0.top.equalTo(textGenre.snp.top)
            $0.leading.equalTo(textGenre.snp.trailing).offset(10)
        }
        
        starImage.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-25)
            $0.leading.equalTo(textGenre.snp.leading)
            $0.width.equalTo(35)
            $0.height.equalTo(35)
        }
    }
    
}
