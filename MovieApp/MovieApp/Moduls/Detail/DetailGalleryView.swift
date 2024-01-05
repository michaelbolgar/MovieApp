//
//  DetailGalleryView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

class DetailGalleryView: UIView {
    
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        addSubview(photo)
        photo.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalTo(25)
            $0.top.equalToSuperview().inset(10)
        }
    }
}

extension DetailGalleryView: Configurable {
    struct Model {
//        let imageURL: URL?
        let imageURL: String?
    }
    
    func update(model: Model) {
        
        guard let imageURL = model.imageURL else {
            photo.image = nil
            return
        }
        // Асинхронная загрузка изображения
//           URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
//               guard let self = self else { return }
//               
//               if let error = error {
//                   // Обработка ошибки загрузки
//                   print("Ошибка загрузки изображения: \(error.localizedDescription)")
//                   return
//               }
//               
//               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                   print("Некорректный ответ сервера")
//                   return
//               }
//               
//               guard let data = data, let image = UIImage(data: data) else {
//                   print("Данные не могут быть преобразованы в изображение")
//                   return
//               }
//               
//               DispatchQueue.main.async {
//                   self.photo.image = image
//               }
//           }.resume()
        photo.image = UIImage(named: "filmPhoto") // УДАЛИТЬ
    }
}
