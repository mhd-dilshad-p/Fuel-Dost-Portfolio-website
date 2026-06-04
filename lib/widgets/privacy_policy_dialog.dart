import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';

class PrivacyPolicyDialog extends StatefulWidget {
  final String fullPolicyUrl;

  const PrivacyPolicyDialog({
    super.key,
    required this.fullPolicyUrl,
  });

  @override
  State<PrivacyPolicyDialog> createState() => _PrivacyPolicyDialogState();
}

class _PrivacyPolicyDialogState extends State<PrivacyPolicyDialog> {
  String _searchQuery = '';
  int _activeTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Helper widget to split and highlight searched text
  Widget _highlightText(String text, String query, TextStyle baseStyle, TextStyle highlightStyle) {
    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }

    final List<TextSpan> spans = [];
    final String lowercaseText = text.toLowerCase();
    final String lowercaseQuery = query.toLowerCase();

    int start = 0;
    while (true) {
      final int index = lowercaseText.indexOf(lowercaseQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: highlightStyle,
      ));

      start = index + query.length;
    }

    return RichText(
      text: TextSpan(children: spans, style: baseStyle),
    );
  }

  Widget _buildDefinitionCard(String term, String definition, String query) {
    final TextStyle termBase = GoogleFonts.sora(
      color: AppColors.accent,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final TextStyle termHighlight = GoogleFonts.sora(
      color: const Color(0xFF0F172A),
      backgroundColor: AppColors.accent.withOpacity(0.25),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final TextStyle defBase = GoogleFonts.dmSans(
      color: const Color(0xFF475569),
      fontSize: 13,
      height: 1.5,
    );
    final TextStyle defHighlight = GoogleFonts.dmSans(
      color: const Color(0xFF0F172A),
      backgroundColor: AppColors.accent.withOpacity(0.25),
      fontWeight: FontWeight.bold,
      fontSize: 13,
      height: 1.5,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _highlightText(term, query, termBase, termHighlight),
          const SizedBox(height: 6),
          _highlightText(definition, query, defBase, defHighlight),
        ],
      ),
    );
  }

  Widget _buildBulletRow(String text, String query) {
    final TextStyle textBase = GoogleFonts.dmSans(
      color: const Color(0xFF334155),
      fontSize: 14,
      height: 1.5,
    );
    final TextStyle textHighlight = GoogleFonts.dmSans(
      color: const Color(0xFF0F172A),
      backgroundColor: AppColors.primary.withOpacity(0.2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
      height: 1.5,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: _highlightText(text, query, textBase, textHighlight),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.sora(
              color: const Color(0xFF0F172A),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 900;

    final TextStyle bodyBase = GoogleFonts.dmSans(
      color: const Color(0xFF334155),
      fontSize: 14,
      height: 1.6,
    );
    final TextStyle bodyHighlight = GoogleFonts.dmSans(
      color: const Color(0xFF0F172A),
      backgroundColor: AppColors.primary.withOpacity(0.25),
      fontWeight: FontWeight.bold,
      fontSize: 14,
      height: 1.6,
    );

    // Define all sections with metadata for searching
    final List<Map<String, dynamic>> allSections = [
      {
        'title': 'Interpretation & Definitions',
        'icon': Icons.gavel_rounded,
        'keywords': 'interpretation definitions account affiliate application company country device personal data service provider usage data you',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _highlightText(
                  'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\nWe use Your Personal Data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                  query,
                  bodyBase,
                  bodyHighlight,
                ),
                const SizedBox(height: 24),
                _buildSectionCard(
                  'Interpretation',
                  _highlightText(
                    'The words whose initial letters are capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                    query,
                    bodyBase,
                    bodyHighlight,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Definitions',
                  style: GoogleFonts.sora(
                    color: const Color(0xFF0F172A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDefinitionCard(
                  'Account',
                  'means a unique account created for You to access our Service or parts of our Service.',
                  query,
                ),
                _buildDefinitionCard(
                  'Affiliate',
                  'means an entity that controls, is controlled by, or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
                  query,
                ),
                _buildDefinitionCard(
                  'Application',
                  'refers to FuelDost, the software program provided by the Company.',
                  query,
                ),
                _buildDefinitionCard(
                  'Company',
                  '(referred to as either "the Company", "We", "Us" or "Our" in this Privacy Policy) refers to FuelDost.',
                  query,
                ),
                _buildDefinitionCard(
                  'Country',
                  'refers to: Kerala, India',
                  query,
                ),
                _buildDefinitionCard(
                  'Device',
                  'means any device that can access the Service such as a computer, a cell phone or a digital tablet.',
                  query,
                ),
                _buildDefinitionCard(
                  'Personal Data',
                  '(or "Personal Information") is any information that relates to an identified or identifiable individual. We use "Personal Data" and "Personal Information" interchangeably unless a law uses a specific term.',
                  query,
                ),
                _buildDefinitionCard(
                  'Service',
                  'refers to the Application.',
                  query,
                ),
                _buildDefinitionCard(
                  'Service Provider',
                  'means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.',
                  query,
                ),
                _buildDefinitionCard(
                  'Usage Data',
                  'refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).',
                  query,
                ),
                _buildDefinitionCard(
                  'You',
                  'means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                  query,
                ),
              ],
            ),
      },
      {
        'title': 'Collecting Your Data',
        'icon': Icons.add_moderator_rounded,
        'keywords': 'collecting types personal data usage device mobile browser ip address diagnostic identifier',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Types of Data Collected',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Data',
                        style: GoogleFonts.sora(
                          color: AppColors.accent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _highlightText(
                        'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to: Usage Data.',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                    ],
                  ),
                ),
                _buildSectionCard(
                  'Usage Data',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        'Usage Data is collected automatically when using the Service.',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                      const SizedBox(height: 12),
                      _highlightText(
                        "Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device's unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit Our Service or when You access the Service by or through a mobile device.",
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      },
      {
        'title': 'Use & Sharing of Data',
        'icon': Icons.share_rounded,
        'keywords': 'use share maintain monitor account contact push updates business transfer partner consent affiliate',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Use of Your Personal Data',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        'The Company may use Personal Data for the following purposes:',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                      const SizedBox(height: 16),
                      _buildBulletRow('To provide and maintain our Service: including to monitor the usage of our Service.', query),
                      _buildBulletRow('To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.', query),
                      _buildBulletRow('For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.', query),
                      _buildBulletRow('To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application\'s push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.', query),
                      _buildBulletRow('To provide You with news, special offers, and general information: about other goods, services and events which We offer that are similar to those that you have already purchased or inquired about unless You have opted not to receive such information.', query),
                      _buildBulletRow('To manage Your requests: To attend and manage Your requests to Us.', query),
                      _buildBulletRow('For business transfers: We may use Your Personal Data to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.', query),
                      _buildBulletRow('For other purposes: We may use Your information for data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.', query),
                    ],
                  ),
                ),
                _buildSectionCard(
                  'Sharing Your Personal Data',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        'We may share Your Personal Data in the following situations:',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                      const SizedBox(height: 16),
                      _buildBulletRow('With Service Providers: We may share Your Personal Data with Service Providers to monitor and analyze the use of our Service, to contact You.', query),
                      _buildBulletRow('For business transfers: We may share or transfer Your Personal Data in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.', query),
                      _buildBulletRow('With Affiliates: We may share Your Personal Data with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.', query),
                      _buildBulletRow('With business partners: We may share Your Personal Data with Our business partners to offer You certain products, services or promotions.', query),
                      _buildBulletRow('With other users: If Our Service offers public areas, when You share Personal Data or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.', query),
                      _buildBulletRow('With Your consent: We may disclose Your Personal Data for any other purpose with Your consent.', query),
                    ],
                  ),
                ),
              ],
            ),
      },
      {
        'title': 'Retention & Transfer',
        'icon': Icons.storage_rounded,
        'keywords': 'retention transfer retention periods duration 24 months backup delete anonymization safeguard',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Retention of Your Personal Data',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations, resolve disputes, and enforce our legal agreements and policies.\n\nWhere possible, We apply shorter retention periods and/or reduce identifiability by deleting, aggregating, or anonymizing data. Unless otherwise stated, the retention periods below are maximum periods ("up to") and We may delete or anonymize data sooner when it is no longer needed for the relevant purpose. We apply different retention periods to different categories of Personal Data based on the purpose of processing and legal obligations:',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                      const SizedBox(height: 16),
                      _buildDefinitionCard('User Accounts', 'Retained for the duration of your account relationship plus up to 24 months after account closure to handle any post-termination issues or resolve disputes.', query),
                      _buildDefinitionCard('Application usage statistics', 'Up to 24 months to understand feature adoption and service improvements.', query),
                      _buildDefinitionCard('Server logs (IP addresses, access times)', 'Up to 24 months for security monitoring and troubleshooting purposes.', query),
                      const SizedBox(height: 8),
                      _highlightText(
                        'When retention periods expire, We securely delete or anonymize Personal Data:\n• Deletion: Personal Data is removed from Our systems and no longer actively processed.\n• Backup retention: Residual copies remain in encrypted backups for a limited period.\n• Anonymization: We convert Personal Data into anonymous statistical data that cannot be linked back to You.',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                    ],
                  ),
                ),
                _buildSectionCard(
                  'Transfer of Your Personal Data',
                  _highlightText(
                    "Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ from those from Your jurisdiction.\n\nWhere required by applicable law, We will ensure that international transfers of Your Personal Data are subject to appropriate safeguards and supplementary measures where appropriate. The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place.",
                    query,
                    bodyBase,
                    bodyHighlight,
                  ),
                ),
              ],
            ),
      },
      {
        'title': 'Delete Your Data',
        'icon': Icons.delete_sweep_rounded,
        'keywords': 'delete assist deleting right settings settings contact request',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Delete Your Personal Data',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.\n\nOur Service may give You the ability to delete certain information about You from within the Service.',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                      const SizedBox(height: 16),
                      _highlightText(
                        'You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any Personal Data that You have provided to Us.\n\nPlease note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      },
      {
        'title': 'Disclosure & Security',
        'icon': Icons.security_rounded,
        'keywords': 'disclosure business transaction law enforcement compliance safety security absolute storage transmission',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Disclosure of Your Personal Data',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDefinitionCard('Business Transactions', 'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.', query),
                      _buildDefinitionCard('Law Enforcement', 'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).', query),
                      _buildDefinitionCard('Other Legal Requirements', 'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to: comply with a legal obligation; protect and defend the rights or property of the Company; prevent or investigate possible wrongdoing in connection with the Service; protect the personal safety of Users of the Service or the public; protect against legal liability.', query),
                    ],
                  ),
                ),
                _buildSectionCard(
                  'Security of Your Personal Data',
                  _highlightText(
                    'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially reasonable means to protect Your Personal Data, We cannot guarantee its absolute security.',
                    query,
                    bodyBase,
                    bodyHighlight,
                  ),
                ),
              ],
            ),
      },
      {
        'title': 'Children & Websites',
        'icon': Icons.child_care_rounded,
        'keywords': 'children privacy age 16 parent consent remove servers links websites update changes notice',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Children\'s Privacy',
                  _highlightText(
                    'Our Service does not address anyone under the age of 16. We do not knowingly collect personally identifiable information from anyone under the age of 16. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 16 without verification of parental consent, We take steps to remove that information from Our servers.\n\nIf We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.',
                    query,
                    bodyBase,
                    bodyHighlight,
                  ),
                ),
                _buildSectionCard(
                  'Links to Other Websites',
                  _highlightText(
                    'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit.\n\nWe have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                    query,
                    bodyBase,
                    bodyHighlight,
                  ),
                ),
                _buildSectionCard(
                  'Changes to this Privacy Policy',
                  _highlightText(
                    'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page. We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.',
                    query,
                    bodyBase,
                    bodyHighlight,
                  ),
                ),
              ],
            ),
      },
      {
        'title': 'Contact Us',
        'icon': Icons.contact_mail_rounded,
        'keywords': 'contact questions email mohammeddilshadputhukkudi@gmail.com support termsfeed',
        'contentBuilder': (String query) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  'Get in Touch',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        'If you have any questions about this Privacy Policy, You can contact us by email at the address below:',
                        query,
                        bodyBase,
                        bodyHighlight,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.email_outlined, color: AppColors.accent, size: 20),
                                  const SizedBox(width: 12),
                                  SelectableText(
                                    'mohammeddilshadputhukkudi@gmail.com',
                                    style: GoogleFonts.dmSans(
                                      color: const Color(0xFF0F172A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: 'mohammeddilshadputhukkudi@gmail.com',
                                  query: 'subject=FuelDost Privacy Inquiry',
                                );
                                if (await canLaunchUrl(emailLaunchUri)) {
                                  await launchUrl(emailLaunchUri);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.send_rounded, size: 18),
                              label: Text(
                                'Send Email',
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          'Generated using TermsFeed Privacy Policy Generator',
                          style: GoogleFonts.dmSans(
                            color: const Color(0xFF64748B).withOpacity(0.5),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      },
    ];

    // Filter sections based on search query
    final List<Map<String, dynamic>> filteredSections = allSections.where((sec) {
      if (_searchQuery.isEmpty) return true;
      final String keywords = sec['keywords'] as String;
      return keywords.contains(_searchQuery.toLowerCase()) ||
          sec['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Ensure _activeTabIndex is within range after filtering
    if (_activeTabIndex >= filteredSections.length && filteredSections.isNotEmpty) {
      _activeTabIndex = 0;
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 720),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC).withOpacity(0.92),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Bar (Title, Search & Close Button)
                    Container(
                      padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_user_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Privacy Policy',
                                  style: GoogleFonts.sora(
                                    color: const Color(0xFF0F172A),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Last updated: May 07, 2026',
                                  style: GoogleFonts.dmSans(
                                    color: const Color(0xFF64748B),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Interactive Search Input
                          Container(
                            width: isDesktop ? 300 : 180,
                            height: 42,
                            margin: const EdgeInsets.only(right: 16),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) {
                                setState(() {
                                  _searchQuery = val;
                                });
                              },
                              style: GoogleFonts.dmSans(
                                color: const Color(0xFF0F172A),
                                fontSize: 13,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search policy...',
                                hintStyle: GoogleFonts.dmSans(
                                  color: const Color(0xFF64748B).withOpacity(0.6),
                                  fontSize: 13,
                                ),
                                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 18),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear_rounded, color: Color(0xFF64748B), size: 16),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() {
                                            _searchQuery = '';
                                          });
                                        },
                                      )
                                    : null,
                                filled: true,
                                fillColor: const Color(0xFFF1F5F9),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                          // Close Button
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Color(0xFF475569),
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Pane Area
                    Expanded(
                      child: filteredSections.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.search_off_rounded, size: 64, color: Color(0xFF94A3B8)),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No matching sections found',
                                    style: GoogleFonts.sora(
                                      color: const Color(0xFF64748B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Try searching other keywords like "usage", "retain", or "delete".',
                                    style: GoogleFonts.dmSans(color: const Color(0xFF94A3B8), fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          : isDesktop
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Sidebar Navigation Pane (Desktop)
                                    Container(
                                      width: 250,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF1F5F9),
                                        border: Border(
                                          right: BorderSide(
                                            color: Color(0xFFE2E8F0),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                        itemCount: filteredSections.length,
                                        itemBuilder: (context, index) {
                                          final sec = filteredSections[index];
                                          final bool isActive = _activeTabIndex == index;
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 6.0),
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _activeTabIndex = index;
                                                    });
                                                  },
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Container(
                                                    padding: const EdgeInsets.fromLTRB(16, 12, 14, 12),
                                                    decoration: BoxDecoration(
                                                      color: isActive
                                                          ? AppColors.primary.withOpacity(0.08)
                                                          : Colors.transparent,
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(
                                                        color: isActive
                                                            ? AppColors.primary.withOpacity(0.12)
                                                            : Colors.transparent,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          sec['icon'] as IconData,
                                                          color: isActive ? AppColors.primary : const Color(0xFF475569),
                                                          size: 18,
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Expanded(
                                                          child: Text(
                                                            sec['title'] as String,
                                                            style: GoogleFonts.sora(
                                                              color: isActive ? const Color(0xFF0F172A) : const Color(0xFF475569),
                                                              fontSize: 13,
                                                              fontWeight: isActive
                                                                  ? FontWeight.bold
                                                                  : FontWeight.normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                if (isActive)
                                                  Positioned(
                                                    left: 0,
                                                    top: 8,
                                                    bottom: 8,
                                                    width: 4,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.primary,
                                                        borderRadius: BorderRadius.circular(2),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Main Content Pane (Desktop)
                                    Expanded(
                                      child: Container(
                                        color: const Color(0xFFF8FAFC).withOpacity(0.5),
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filteredSections[_activeTabIndex]['title'] as String,
                                                style: GoogleFonts.sora(
                                                  color: const Color(0xFF0F172A),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: -0.5,
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              (filteredSections[_activeTabIndex]['contentBuilder'] as Widget Function(String))(
                                                _searchQuery,
                                              ),
                                            ],
                                          ).animate(key: ValueKey('sec_$_activeTabIndex')).fadeIn(duration: 300.ms).slideX(begin: 0.03, end: 0, curve: Curves.easeOut),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  // Mobile View: Horizontal Tabs + Scrollable content
                                  children: [
                                    Container(
                                      height: 52,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF1F5F9),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFE2E8F0),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        itemCount: filteredSections.length,
                                        itemBuilder: (context, index) {
                                          final sec = filteredSections[index];
                                          final bool isActive = _activeTabIndex == index;
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _activeTabIndex = index;
                                                });
                                              },
                                              borderRadius: BorderRadius.circular(20),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                decoration: BoxDecoration(
                                                  color: isActive
                                                      ? AppColors.primary.withOpacity(0.08)
                                                      : Colors.white,
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: isActive
                                                        ? AppColors.primary.withOpacity(0.15)
                                                        : const Color(0xFFE2E8F0),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      sec['icon'] as IconData,
                                                      color: isActive ? AppColors.primary : const Color(0xFF475569),
                                                      size: 14,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      sec['title'] as String,
                                                      style: GoogleFonts.sora(
                                                        color: isActive ? const Color(0xFF0F172A) : const Color(0xFF475569),
                                                        fontSize: 12,
                                                        fontWeight: isActive
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              filteredSections[_activeTabIndex]['title'] as String,
                                              style: GoogleFonts.sora(
                                                color: const Color(0xFF0F172A),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            (filteredSections[_activeTabIndex]['contentBuilder'] as Widget Function(String))(
                                              _searchQuery,
                                            ),
                                          ],
                                        ).animate(key: ValueKey('mobile_sec_$_activeTabIndex')).fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
                                      ),
                                    ),
                                  ],
                                ),
                    ),

                    // Bottom CTA Action Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        border: Border(
                          top: BorderSide(
                            color: const Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Need a copy? Link to live terms document.',
                            style: GoogleFonts.dmSans(
                              color: const Color(0xFF64748B),
                              fontSize: isDesktop ? 12 : 10,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF475569),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                ),
                                child: Text(
                                  'Close Dialog',
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  final Uri uri = Uri.parse(widget.fullPolicyUrl);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF0F172A),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                                  ),
                                ),
                                icon: const Icon(Icons.open_in_new_rounded, size: 14),
                                label: Text(
                                  'TermsFeed Link',
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
