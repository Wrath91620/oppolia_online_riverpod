// constants.dart

class MoraApiConstants {
  // Base URL for the MORA API
  static const String baseUrl = "https://mora-sa.com/api/v1";

  // Endpoints
  static const String sendSmsEndpoint = "$baseUrl/sendsms";
  static const String balanceEndpoint = "$baseUrl/balance";
  static const String senderNamesEndpoint = "$baseUrl/sender_names";

  // API Credentials (Replace these with secure storage methods in production)
  static const String apiKey = "47e99c42bbe91c1a52048c3582d926436fb31594";
  static const String username = "Muneef";
  static const String senderName = "OPPOLIA";

  // Other Constants
  static const String defaultMessageFormat = "json"; // or "text"
}
