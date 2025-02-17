import UIKit


// Task 1.1 Profile Management System ------------------------------

// еще struct enum, хранятся в стеке тоесть копируются
// а вот классы в куче и управляется ARC


protocol ProfileUpdateDelegate : AnyObject {
    // DONE: Consider protocol inheritance requirements
    // Think: When should we restrict protocol to reference types only?
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager {
    // TODO: Think about appropriate storage type for active profiles
    var activeProfiles: [String: UserProfile]
    
    // DONE: Consider reference type for delegate
    weak var delegate: ProfileUpdateDelegate? // weak это свойство только для classов поэтому нам нужно присвоить протоколу anyobject
    
    // TODO: Think about reference management in closure
    var onProfileUpdate: ((UserProfile) -> Void)? // так как замыкание может удерживаться стоит использовать внутри [weak self]
    
    init(delegate: ProfileUpdateDelegate) {
        // TODO: Implement initialization
        self.delegate = delegate
        self.activeProfiles = [:]
    }
    
    func loadProfile(id: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        // TODO: Implement profile loadingв
        // Consider: How to avoid retain cycle in completion handler?
        
        
    }
}

class UserProfileViewController : ProfileUpdateDelegate {
    var profileManager: ProfileManager?
    //тут должен профайл менеджера держать сильной ссылкой потому что если они оба будут со слабой то профайл менеджер исчезнет сразу после инициализации
    //тоесть вью контроллер должен держать менеджера сильной ссылкой потому что без него вью контроллер не будет работать
    // а вот менеджер держит слабой ссылкой вью контроллер ибо если он удалится то он больше не нужен в памяти
    // получается если исчезнет вью контроллер просто делегат у менеджера станет nil и все
    // чисто для себя менеджер робот, вью контроллер пульт который работает с ним
    
    var imageLoader: ImageLoader?
    
    func setupProfileManager() {
        // TODO: Implement setup
        // Think: What reference type should be used in closure?
        profileManager = ProfileManager(delegate: self)
        
    }
    
    func updateProfile() {
        // TODO: Implement profile update
        // Consider: How to handle closure capture list?
        
        guard let profileId = profileManager?.activeProfiles.keys.first else {
            return
        }
        
        profileManager?.loadProfile(id: profileId) { [weak self] result in
            guard let self = self else {
                return
            }
            
            
            switch result {
            case .success(let profile):
                print(profile)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func profileDidUpdate(_ profile: UserProfile) {
        print("Профиль обновлён: \(profile.username)")
    }
    
    func profileLoadingError(_ error: Error) {
        print("Ошибка при загрузке профиля: \(error.localizedDescription)")
    }
}

// Task 1.2 Image Loading System ------------------------------

protocol ImageLoaderDelegate : AnyObject {
    // TODO: Think about protocol requirements
    // Consider: What types can conform to this protocol?
    // Consider: How does this affect memory management?
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}

class ImageLoader {
    // TODO: Consider reference type for delegate
    weak var delegate: ImageLoaderDelegate?
    // по той же причине тут нужен weak
    
    // TODO: Think about closure reference type
    var completionHandler: ((UIImage?) -> Void)?
    
    func loadImage(url: URL) {
        // TODO: Implement image loading
        // Consider: How to avoid retain cycle?
        let success = Bool.random()

            if success {
                let fakeImage = UIImage()
                print("Картинка загружена")
                
//                delegate?.imageLoader(self, didLoad: fakeImage)
                completionHandler?(fakeImage)
            } else {
    
                print("Ошибка загрузки картинки")

                delegate?.imageLoader(self, didFailWith: NSError())
                completionHandler?(nil)
            }
    }
}

class PostView : ImageLoaderDelegate {
    // TODO: Consider reference management
    var imageLoader: ImageLoader?
    // тут нужен стронг ссылка, так как если бы он был бы weak то imageLoader сразу бы исчез
    // еще так как они бы оба держали бы друг друга слабой ссылкой то они бы оба исчезли
    // и вот если PostView допустим если исчез то ImageLoader тоже так как он никому не нужен
    // а вот PostView нужен сильной ссылкой так как если ImageLoadera не будет то он попросту не сможет загружать картинки
    //omg
    
    func setupImageLoader() {
        // TODO: Implement setup
        // Think: What reference types should be used?
        imageLoader = ImageLoader()
        imageLoader?.delegate = self //ну тут все просто кажется
        
        imageLoader?.completionHandler = { [weak self] image in
            // почему тут weak self ибо он мог бы удерживать imageloader что могло бы привести к утечке памяти
            guard let self = self else { return }
            print("все супер картинка у нас")
            self.exampleUpdateUI()
        }
    }
    
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        print("all good")
        self.exampleUpdateUI()
    }
    
    func imageLoader(_ loader: ImageLoader, didFailWith error: any Error) {
        print("not good")
    }
    
    func exampleUpdateUI(){
        print("updated")
    }
}


//Task 2.1: Feed System Implementation ------------------------------

class Node<T> {
    var value: T
    var next: Node<T>?
    var prev: Node<T>?
    
    init(value: T){
        self.value = value
    }
}

class LinkedList<T: Equatable>{
    private var head: Node<T>?
    private var tail: Node<T>?
    
    
    func insertAtBeginning(_ value: T) {
        let newNode = Node(value: value)
        
        if let firstNode = head {
            newNode.next = firstNode
            firstNode.prev = newNode
        } else {
            tail = newNode
        }
    }
    
    func removeLast(){
        guard let lastNode = tail else { return }
        
        if let prevNode = lastNode.prev {
            prevNode.next = nil
        } else {
            head = nil
        }
        
        tail = lastNode.prev
    }
}

class FeedSystem {
    // TODO: Implement cache storage
    // Consider: Which collection type is best for fast lookup?
    // Requirements: O(1) access time, storing UserProfile objects with UserID keys
    private var userCache: [UUID : UserProfile] = [:]
    
    // TODO: Implement feed storage
    // Consider: Which collection type is best for ordered data?
    // Requirements: Maintain post order, frequent insertions at the beginning
    
    //тут два варика
    //первый это реализовывать linked list
    //либо просто использовать массив другого варианта нету
    private var feedPosts : LinkedList<Post>?
    private var feedPosts2 : [Post] = []
    
    // TODO: Implement hashtag storage
    // Consider: Which collection type is best for unique values?
    // Requirements: Fast lookup, no duplicates
    private var hashtags : Set<String> = []
    
    func addPost(_ post: Post) {
        // TODO: Implement post addition
        // Consider: Which collection operations are most efficient?
        feedPosts?.insertAtBeginning(post)
        feedPosts2.insert(post, at: 0)
    }
    
    func removePost(_ post: Post) {
        // TODO: Implement post removal
        // Consider: Performance implications of removal
        feedPosts?.removeLast()
        feedPosts2.forEach{ value in
            if value == post {
                feedPosts2.remove(at: feedPosts2.firstIndex(of: value)!)
            }
        }
        
    }
}


// Part 3: Hashable and Equatable Implementation ----------

struct UserProfile {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int
    
    // TODO: Implement Hashable
    // Consider: Which properties should be used for hashing?
    // Remember: Only use immutable properties
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // TODO: Implement Equatable
    // Consider: Which properties determine equality?
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Post : Equatable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int
    
    // TODO: Implement Hashable
    // Consider: Which properties should be used for hashing?
    func hash(into hasher: inout Hasher) {// inout ключевое слово - передается по ссылке
        hasher.combine(id)
    }
    
    // TODO: Implement Equatable
    // Consider: When should two posts be considered equal?
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.authorId == rhs.authorId
    }
}
