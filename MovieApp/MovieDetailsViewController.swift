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
        
    var overview: OverviewView
    
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
        
        self.overview = OverviewView()
        
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
        self.view.addSubview(overview)
        
        //  Main info
        mainInfoBgImage.contentMode = .scaleAspectFill
        mainInfoBgImage.clipsToBounds = true
        mainInfoView.addSubview(mainInfoBgImage)
        
        mainInfoView.addSubview(mainInfoScore)
        mainInfoView.addSubview(mainInfoText)
                
        mainInfoScorePercentage.text = "86%"
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
        overview.snp.makeConstraints{
            $0.top.equalTo(mainInfoView.snp.bottom)
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view.safeAreaLayoutGuide).dividedBy(2)
        }
    }
}
