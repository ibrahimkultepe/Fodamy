// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Base {
    /// Try Again
    public static let errorButtonTitle = L10n.tr("Modules", "Base.errorButtonTitle")
  }

  public enum CommentEntryView {
    /// Bir şey yaz...
    public static let placeholderLabel = L10n.tr("Modules", "CommentEntryView.placeholderLabel")
  }

  public enum FavoritesCollectionViewCell {
    /// TÜMÜNÜ GÖR
    public static let seeAllButton = L10n.tr("Modules", "FavoritesCollectionViewCell.seeAllButton")
  }

  public enum ForgotPassword {
    /// Tamam
    public static let alertControllerAcceptAction = L10n.tr("Modules", "ForgotPassword.alertControllerAcceptAction")
    /// E-mailinizi kontrol edip, paralonızı değiştirebilirsiniz.
    public static let alertControllerMesssage = L10n.tr("Modules", "ForgotPassword.alertControllerMesssage")
    /// Parolanız Sıfırlandı.
    public static let alertControllerTitle = L10n.tr("Modules", "ForgotPassword.alertControllerTitle")
    /// E-mail Adresi
    public static let emailTextField = L10n.tr("Modules", "ForgotPassword.emailTextField")
    /// Parolayı Sıfırla
    public static let forgotPasswordButton = L10n.tr("Modules", "ForgotPassword.forgotPasswordButton")
    /// Parolanızı Sıfırlayın
    public static let titleLabel = L10n.tr("Modules", "ForgotPassword.titleLabel")
  }

  public enum Home {
    /// EDİTÖR SEÇİMİ
    public static let segmentedControl0 = L10n.tr("Modules", "Home.segmentedControl0")
    /// SON EKLENENLER
    public static let segmentedControl1 = L10n.tr("Modules", "Home.segmentedControl1")
  }

  public enum Login {
    /// Hesabın mı yok? 
    public static let bottomLabel = L10n.tr("Modules", "Login.bottomLabel")
    /// Şifrenizi mi unuttunuz ?
    public static let forgotPasswordButton = L10n.tr("Modules", "Login.forgotPasswordButton")
    /// Giriş yap
    public static let loginButton = L10n.tr("Modules", "Login.loginButton")
    /// Şifre
    public static let passwordTextField = L10n.tr("Modules", "Login.passwordTextField")
    /// Üye Ol
    public static let signUpButton = L10n.tr("Modules", "Login.signUpButton")
    /// Giriş Yap
    public static let titleLabel = L10n.tr("Modules", "Login.titleLabel")
    /// Kullanıcı Adı
    public static let userNameTextField = L10n.tr("Modules", "Login.userNameTextField")
  }

  public enum LoginWarning {
    /// Vazgeç
    public static let giveUpButton = L10n.tr("Modules", "LoginWarning.giveUpButton")
    /// Giriş Yap
    public static let loginButton = L10n.tr("Modules", "LoginWarning.loginButton")
    /// Giriş yapmanız gereklidir.
    public static let warningLabel = L10n.tr("Modules", "LoginWarning.warningLabel")
  }

  public enum NavigationController {
    /// Geri
    public static let backButtonTitle = L10n.tr("Modules", "NavigationController.backButtonTitle")
  }

  public enum RecipeDetail {
    /// İptal
    public static let cancelAction = L10n.tr("Modules", "RecipeDetail.cancelAction")
    /// Yorum
    public static let commentViewInfo = L10n.tr("Modules", "RecipeDetail.CommentViewInfo")
    /// Beğeni
    public static let likeViewInfo = L10n.tr("Modules", "RecipeDetail.LikeViewInfo")
    /// Takibi Bırak
    public static let unfollowAction = L10n.tr("Modules", "RecipeDetail.unfollowAction")
  }

  public enum RecipeDetailComment {
    /// Yorum Ekle
    public static let buttonTitle = L10n.tr("Modules", "RecipeDetailComment.buttonTitle")
    /// Yorumlar
    public static let title = L10n.tr("Modules", "RecipeDetailComment.title")
  }

  public enum RecipeDetailInfo {
    /// Yapılışı
    public static let instructions = L10n.tr("Modules", "RecipeDetailInfo.instructions")
    /// Malzemeler
    public static let materials = L10n.tr("Modules", "RecipeDetailInfo.materials")
  }

  public enum Register {
    /// Tamam
    public static let alertControllerAcceptAction = L10n.tr("Modules", "Register.alertControllerAcceptAction")
    /// Yemek tariflerine hoşgeldiniz.
    public static let alertControllerMesssage = L10n.tr("Modules", "Register.alertControllerMesssage")
    /// Üyelik işleminiz başarılı.
    public static let alertControllerTitle = L10n.tr("Modules", "Register.alertControllerTitle")
    /// Hesabın mı var ?
    public static let bottomLabel = L10n.tr("Modules", "Register.bottomLabel")
    /// E-mail Adresi
    public static let emailTextField = L10n.tr("Modules", "Register.emailTextField")
    /// Giriş yap
    public static let loginButton = L10n.tr("Modules", "Register.loginButton")
    /// Şifre
    public static let passwordTextField = L10n.tr("Modules", "Register.passwordTextField")
    /// Üye Ol
    public static let signUpButton = L10n.tr("Modules", "Register.signUpButton")
    /// Üye Ol
    public static let titleLabel = L10n.tr("Modules", "Register.titleLabel")
    /// Kullanıcı Adı
    public static let userNameTextField = L10n.tr("Modules", "Register.userNameTextField")
  }

  public enum UserDefaultsKeys {
    /// WalkthroughFinished
    public static let didFinishWalkthrough = L10n.tr("Modules", "UserDefaultsKeys.didFinishWalkthrough")
  }

  public enum UserView {
    /// Takip Ediliyor
    public static let following = L10n.tr("Modules", "UserView.following")
    /// Takip et
    public static let notFollowing = L10n.tr("Modules", "UserView.notFollowing")
  }

  public enum Validation {
    /// Lütfen geçerli bir email adresi giriniz.
    public static let isValidEmail = L10n.tr("Modules", "Validation.isValidEmail")
    /// Lütfen İsminizi Giriniz
    public static let isValidName = L10n.tr("Modules", "Validation.isValidName")
    /// Şifreniz en az 6 karaterden oluşmalıdır.
    public static let isValidPassword = L10n.tr("Modules", "Validation.isValidPassword")
  }

  public enum WalkThrough {
    /// Fodamy is the best place to find your favorite recipes in all around the word.
    public static let description = L10n.tr("Modules", "WalkThrough.description")
    /// Welcome to Fodamy Network!
    public static let firtsTitle = L10n.tr("Modules", "WalkThrough.firtsTitle")
    /// Share recipes with others.
    public static let fourthTitle = L10n.tr("Modules", "WalkThrough.fourthTitle")
    /// Next
    public static let nextButtonTitle = L10n.tr("Modules", "WalkThrough.nextButtonTitle")
    /// Finding recipes were not that easy.
    public static let secondTitle = L10n.tr("Modules", "WalkThrough.secondTitle")
    /// Start
    public static let startButtonTitle = L10n.tr("Modules", "WalkThrough.startButtonTitle")
    /// Add new recipe.
    public static let thirdTitle = L10n.tr("Modules", "WalkThrough.thirdTitle")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
