import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.kinopoisk.dev"
    static let hostForMovie = "www.kinopoisk.vip"
    static let apiKey = Token.sixth
}

struct Token {
    static let first = "AGKSKKE-31E4TH5-GRPZKKD-K00YT2E"
    static let second = "SECH8RE-B9ZM292-G4TH71N-7AEWMFN"
    static let third = "486MEQ2-APQ41CP-GT0N0R2-MWE59JA"
    static let fourth = "QC4AKM6-2YZ42H6-NQT8M9Z-P1MC2JP"
    static let fifth = "DKE1X88-Q19MYCZ-KHTKXKH-F3SAAPM"
    static let sixth = "TRF6JF1-JVH4RW9-K5Q58CC-MFB4GKM"
}

//you can generate more apiKeys on https://t.me/kinopoiskdev_bot if you've exceeded the daily requests limit (200 requests/day)
