//
//  Question.swift
//  Personal Quiz
//
//  Created by Alexey Efimov on 20/06/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

extension Question {
    
    static func getQuestions() -> [Question] {
        return [
            Question(
                text: "Какую пищу предпочитаете?",
                type: .single,
                answers: [
                    Answer(text: "Стейк", type: .dog),
                    Answer(text: "Рыба", type: .cat),
                    Answer(text: "Морковь", type: .rabbit),
                    Answer(text: "Кукуруза", type: .turtle)
                ]
            ),
            Question(
                text: "Что вам нравиться больше?",
                type: .multiple,
                answers: [
                    Answer(text: "Плавать", type: .turtle),
                    Answer(text: "Спать", type: .cat),
                    Answer(text: "Обниматься", type: .rabbit),
                    Answer(text: "Есть", type: .dog)
                ]
            ),
            Question(
                text: "Любите ли вы поездки на машине?",
                type: .ranged,
                answers: [
                    Answer(text: "Ненавижу", type: .cat),
                    Answer(text: "Нервничаю", type: .rabbit),
                    Answer(text: "Не замечаю", type: .turtle),
                    Answer(text: "Обожаю", type: .dog)
                ]
            ),
        ]
    }
}
