import Foundation

struct LessonData {
    
    static let encouragementMessages = [
            "You did it!",
            "Almost there!",
            "Try one more time",
            "Let's learn together."
        ]
    
    static let allLessons: [Lesson] = [
        // MARK: SELF-CARE (ME)
        Lesson(
            title: "My body",
            phrases: [
                Phrase(nativeText: "I am in pain", targetText: "Estou com dor", audioFileName: "dor_audio", imageName: "bandage.fill", category: .selfCare),
                Phrase(nativeText: "My head hurts", targetText: "Minha cabeça dói", audioFileName: "cabeca_audio", imageName: "cross.case.fill", category: .selfCare),
                Phrase(nativeText: "My tummy hurts", targetText: "Minha barriga dói", audioFileName: "barriga_audio", imageName: "pills.fill", category: .selfCare),
                Phrase(nativeText: "I am sick", targetText: "Estou doente", audioFileName: "doente_audio", imageName: "thermometer", category: .selfCare)
            ],
            description: "Learn to tell when something is wrong with your body.",
            category: .selfCare,
            order: 1,
            
        ),
                
        Lesson(
            title: "I am...",
            phrases: [
                Phrase(nativeText: "I am cold", targetText: "Estou com frio", audioFileName: "frio_audio", imageName: "snowflake", category: .selfCare),
                Phrase(nativeText: "I am hot", targetText: "Estou com calor", audioFileName: "calor_audio", imageName: "sun.max.fill", category: .selfCare),
                Phrase(nativeText: "I am fine", targetText: "Estou bem", audioFileName: "bem_audio", imageName: "hand.thumbsup.fill", category: .selfCare),
                Phrase(nativeText: "I am tired", targetText: "Estou cansado(a)", audioFileName: "cansado_audio", imageName: "zzz", category: .selfCare),
                Phrase(nativeText: "I am happy", targetText: "Estou feliz", audioFileName: "feliz_audio", imageName: "face.smiling", category: .selfCare),
                Phrase(nativeText: "I am sad", targetText: "Estou triste", audioFileName: "triste_audio", imageName: "cloud.rain.fill", category: .selfCare)
            ],
            description: "Words to express your feelings and temperature.",
            category: .selfCare,
            order: 2,
           
        ),
        
        Lesson(
            title: "I Need Rest",
            phrases: [
                Phrase(
                    nativeText: "I need to rest",
                    targetText: "Preciso descansar",
                    audioFileName: "descansar_audio",
                    imageName: "bed.double.fill",
                    category: .selfCare
                ),
                Phrase(
                    nativeText: "I need a break",
                    targetText: "Preciso de um tempo",
                    audioFileName: "tempo_audio",
                    imageName: "pause.circle.fill",
                    category: .selfCare
                ),
                Phrase(
                    nativeText: "I am sleepy",
                    targetText: "Estou com sono",
                    audioFileName: "sono_audio",
                    imageName: "moon.zzz.fill",
                    category: .selfCare
                ),
            ],
            description: "Say when you need to rest or slow down.",
            category: .selfCare,
            order: 3,
        ),
        
        Lesson(
            title: "My Comfort",
            phrases: [
                Phrase(
                    nativeText: "I am comfortable",
                    targetText: "Estou confortável",
                    audioFileName: "confortavel_audio",
                    imageName: "checkmark.circle.fill",
                    category: .selfCare
                ),
                Phrase(
                    nativeText: "I am uncomfortable",
                    targetText: "Estou desconfortável",
                    audioFileName: "desconfortavel_audio",
                    imageName: "exclamationmark.circle.fill",
                    category: .selfCare
                ),
                Phrase(
                    nativeText: "I like this",
                    targetText: "Eu gosto disso",
                    audioFileName: "gosto_audio",
                    imageName: "hand.thumbsup.fill",
                    category: .selfCare
                ),
                Phrase(
                    nativeText: "I don't like this",
                    targetText: "Eu não gosto disso",
                    audioFileName: "naogosto2_audio",
                    imageName: "hand.thumbsdown.fill",
                    category: .selfCare
                )
            ],
            description: "Simple phrases to feel comfortable and safe.",
            category: .selfCare,
            order: 5,
        ),
        
        // MARK: - CATEGORIA: NEEDS (NECESSIDADES)
        
        Lesson(
            title: "How I Feel",
            phrases: [
                Phrase(
                    nativeText: "I am sick",
                    targetText: "Estou doente",
                    audioFileName: "doente_audio",
                    imageName: "cross.case.fill",
                    category: .needs
                ),
                Phrase(
                    nativeText: "I am tired",
                    targetText: "Estou cansado(a)",
                    audioFileName: "cansado_audio",
                    imageName: "zzz",
                    category: .needs
                ),
                Phrase(
                    nativeText: "I am in pain",
                    targetText: "Estou com dor",
                    audioFileName: "dor_audio",
                    imageName: "bandage.fill",
                    category: .needs
                ),
                Phrase(
                    nativeText: "My head hurts",
                    targetText: "Minha cabeça dói",
                    audioFileName: "cabeca_audio",
                    imageName: "brain.head.profile",
                    category: .needs
                )
            ],
            description: "Essential things you need every day.",
            category: .needs,
            order: 1,
        ),
        Lesson(
            title: "I Need to Stop",
            phrases: [
                Phrase(
                    nativeText: "Please stop",
                    targetText: "Por favor, pare",
                    audioFileName: "pare_audio",
                    imageName: "hand.raised.fill",
                    category: .needs
                ),
                Phrase(
                    nativeText: "I don't like this",
                    targetText: "Eu não gosto disso",
                    audioFileName: "naogosto_audio",
                    imageName: "hand.thumbsdown.fill",
                    category: .needs
                ),
                Phrase(
                    nativeText: "I am scared",
                    targetText: "Estou com medo",
                    audioFileName: "medo_audio",
                    imageName: "exclamationmark.triangle.fill",
                    category: .needs
                ),
                Phrase(
                    nativeText: "I need a break",
                    targetText: "Preciso de um tempo",
                    audioFileName: "tempo_audio",
                    imageName: "pause.circle.fill",
                    category: .needs
                )
            ],
            description: "Say when you feel uncomfortable or need a break.",
            category: .needs,
            order: 2
        ),
        
        Lesson(
            title: "Asking for help",
            phrases: [
                Phrase(nativeText: "I need help", targetText: "Preciso de ajuda", audioFileName: "ajuda1_audio", imageName: "lifepreserver.fill", category: .needs),
                Phrase(nativeText: "Can you help me, please?", targetText: "Pode me ajudar, por favor?", audioFileName: "ajuda2_audio", imageName: "hand.raised.fill", category: .needs),
                Phrase(nativeText: "How do you say this?", targetText: "Como se diz isso em português?", audioFileName: "comosediz_audio", imageName: "book.fill", category: .needs),
                Phrase(nativeText: "I didn't understand", targetText: "Não entendi", audioFileName: "naoentendi_audio", imageName: "questionmark.circle.fill", category: .needs),
                Phrase(nativeText: "Can you repeat slowly?", targetText: "Pode repetir devagar?", audioFileName: "repetir_audio", imageName: "arrow.triangle.2.circlepath", category: .needs)
            ],
            description: "How to ask for help at school and understand it better.",
            category: .needs,
            order: 3,
            
        ),
        Lesson(
            title: "My Needs",
            phrases: [
                Phrase(nativeText: "I am hungry", targetText: "Estou com fome", audioFileName: "fome_audio", imageName: "fork.knife", category: .needs),
                Phrase(nativeText: "I am thirsty", targetText: "Estou com sede", audioFileName: "sede_audio", imageName: "drop.fill", category: .needs),
                Phrase(nativeText: "Can I go to the bathroom?", targetText: "Posso ir ao banheiro?", audioFileName: "banheiro_audio", imageName: "toilet.fill", category: .needs)
            ],
            description: "Essential things you need every day.",
            category: .needs,
            order: 4,
            
        ),
        
        // MARK: - CATEGORIA: SOCIAL
        
        Lesson(
            title: "Greetings",
            phrases: [
                Phrase(nativeText: "My name is...", targetText: "Meu nome é...", audioFileName: "nome_audio", imageName: "person.text.rectangle", category: .social),
                Phrase(nativeText: "I am from...", targetText: "Eu sou de...", audioFileName: "deonde_audio", imageName: "globe.americas.fill", category: .social),
                Phrase(nativeText: "I am new here...", targetText: "Eu sou novo aqui...", audioFileName: "sounovo_audio", imageName: "globe.americas.fill", category: .social),
                Phrase(nativeText: "Nice to meet you", targetText: "Prazer em te conhecer", audioFileName: "prazer_audio", imageName: "hand.wave.fill", category: .social),
            ],
            description: "Learn how to introduce yourself to your new colleagues.",
            category: .social,
            order: 1,
            
        ),
        
        Lesson(
            title: "Making Friends",
            phrases: [
                Phrase(nativeText: "What is your name?", targetText: "Qual é o seu nome?", audioFileName: "qualnome_audio", imageName: "person.crop.circle.badge.questionmark", category: .social),
                Phrase(nativeText: "You are my friend", targetText: "Você é meu amigo", audioFileName: "amigo_audio", imageName: "figure.2.arms.open", category: .social),
                Phrase(
                    nativeText: "I like you",
                    targetText: "Eu gosto de você",
                    audioFileName: "ilikeyou_audio",
                    imageName: "heart.fill",
                    category: .social
                ),
                Phrase(
                    nativeText: "Can I sit with you?",
                    targetText: "Posso sentar com você?",
                    audioFileName: "sitwithyou_audio",
                    imageName: "chair.fill",
                    category: .social
                )
            ],
            description: "Learn how to first talk to your new colleagues.",
            category: .social,
            order: 2,
            
        ),
        
        Lesson(
            title: "Play Time!",
            phrases: [
                Phrase(nativeText: "Do you want to play with me?", targetText: "Quer brincar comigo?", audioFileName: "brincar1_audio", imageName: "figure.play", category: .social),
                Phrase(nativeText: "Let's play!", targetText: "Vamos jogar!", audioFileName: "jogar_audio", imageName: "gamecontroller.fill", category: .social),
                Phrase(nativeText: "Can I play too?", targetText: "Posso brincar também?", audioFileName: "brincar2_audio", imageName: "figure.wave", category: .social),
                Phrase(nativeText: "I like this", targetText: "Eu gosto disso", audioFileName: "gosto_audio", imageName: "heart.fill", category: .social),
                Phrase(nativeText: "Cool!", targetText: "Legal!", audioFileName: "legal_audio", imageName: "star.fill", category: .social)
            ],
            description: "Phrases to use during recess and playtime.",
            category: .social,
            order: 3,
            
        ),
        
        Lesson(
            title: "Being Polite",
            phrases: [
                Phrase(
                    nativeText: "Please",
                    targetText: "Por favor",
                    audioFileName: "porfavor_audio",
                    imageName: "hands.sparkles.fill",
                    category: .social
                ),
                Phrase(
                    nativeText: "Thank you",
                    targetText: "Obrigado(a)",
                    audioFileName: "obrigado_audio",
                    imageName: "heart.circle.fill",
                    category: .social
                ),
                Phrase(
                    nativeText: "You're welcome",
                    targetText: "De nada",
                    audioFileName: "denada_audio",
                    imageName: "hand.thumbsup.fill",
                    category: .social
                ),
                Phrase(
                    nativeText: "Sorry",
                    targetText: "Desculpa",
                    audioFileName: "desculpa_audio",
                    imageName: "face.smiling.inverse",
                    category: .social
                ),
                Phrase(
                    nativeText: "Excuse me",
                    targetText: "Com licença",
                    audioFileName: "licenca_audio",
                    imageName: "arrow.right.circle.fill",
                    category: .social
                )
            ],
            description: "Simple polite phrases to talk to others every day.",
            category: .social,
            order: 4,
        )
        
    ]
    
}
