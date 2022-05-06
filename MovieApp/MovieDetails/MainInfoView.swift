import UIKit
import SnapKit

class MainInfoView: UIView{
    
    var bgImage: UIImageView!
    
    var infoView: UIView!
    
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
    
    func reloadData(movie: MovieDetails){
        textTitle.text = movie.original_title
        textTitleYear.text = movie.release_date.components(separatedBy: "-")[0]
        textDate.text = movie.release_date.replacingOccurrences(of: "-", with: "/")
        
        var genresText = ""
        for g in movie.genres{
            if genresText == ""{
                genresText.append(g.name)
            }
            else{
                genresText.append(", ")
                genresText.append(g.name)
            }
        }
        textGenre.text = genresText
        
        let durationMinutes = movie.runtime
        let durationHours: Int = durationMinutes / 60
        let durationText = String(durationHours) + "h " + String(durationMinutes - durationHours * 60) + "m"
        textDuration.text = durationText

    }
    
    func buildViews(){
        bgImage = UIImageView(image: UIImage())
        infoView = UIView()
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
        
                
        scorePercentage.text = "86%"
        scorePercentage.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        scoreText.text = "User Score"
        scoreText.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        textTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textTitleYear.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textDate.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textGenre.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textDuration.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        infoView.layer.shadowColor = UIColor.black.cgColor
        infoView.layer.shadowRadius = 8.0
        infoView.layer.shadowOpacity = 1.0
        infoView.layer.shadowOffset = .zero //CGSize(width: 200, height: 200)
        infoView.layer.masksToBounds = false
        
        scorePercentage.textColor = .white
        scoreText.textColor = .white
        textTitle.textColor = .white
        textTitleYear.textColor = .white
        textDate.textColor = .white
        textGenre.textColor = .white
        textDuration.textColor = .white
        
        addSubview(bgImage)
        
        infoView.addSubview(scorePercentage)
        infoView.addSubview(scoreText)
        infoView.addSubview(textTitle)
        infoView.addSubview(textTitleYear)
        infoView.addSubview(textDate)
        infoView.addSubview(textGenre)
        infoView.addSubview(textDuration)
        infoView.addSubview(starImage)
        addSubview(infoView)
        
        
    }
    
    func addConstraints() {
        bgImage.snp.makeConstraints{
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
        
        infoView.snp.makeConstraints{
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
