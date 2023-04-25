// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum UserDefaultsKeys {
    /// WalkthroughFinished
    public static let didFinishWalkthrough = L10n.tr("Modules", "UserDefaultsKeys.didFinishWalkthrough")
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
