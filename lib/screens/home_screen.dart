
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFF167D75);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth >= 750;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 24,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_city_rounded,
              color: primaryColor,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'BayanSense',
              style: TextStyle(
                color: Color(0xFF183B38),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Log In'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 36,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                      isWideScreen ? 48 : 28,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F3EF),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: isWideScreen
                        ? Row(
                            children: [
                              Expanded(
                                child: _buildHeroText(context),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: _buildHeroIllustration(),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              _buildHeroText(context),
                              const SizedBox(height: 30),
                              Center(
                                child: _buildHeroIllustration(),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'What you can do with BayanSense',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF183B38),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A simpler way to report concerns in your barangay.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF647571),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth =
                          constraints.maxWidth >= 750
                              ? (constraints.maxWidth - 32) / 3
                              : constraints.maxWidth;

                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: _featureCard(
                              icon: Icons.campaign_outlined,
                              title: 'Submit Concerns',
                              description:
                                  'Share environmental or infrastructure '
                                  'concerns in your community.',
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _featureCard(
                              icon: Icons.route_outlined,
                              title: 'Smart Routing',
                              description:
                                  'Help direct submitted concerns to the '
                                  'appropriate personnel.',
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _featureCard(
                              icon: Icons.track_changes_outlined,
                              title: 'Track Reports',
                              description:
                                  'View your submitted reports and their '
                                  'status in one place.',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Ready to get started?',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF183B38),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Log in to explore the BayanSense experience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF647571),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 220,
                          child: AppButton(
                            label: 'Continue to Login',
                            icon: Icons.arrow_forward_rounded,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/login',
                              );
                            },
                          ),
                        ),

                        // Activity 9: Open the Report Form.
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 220,
                          child: AppButton(
                            label: 'Submit a Concern',
                            icon: Icons.campaign_outlined,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/report',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Center(
                    child: Text(
                      'BayanSense • Community concerns, better organized.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7A8A86),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'YOUR BARANGAY, BETTER CONNECTED',
            style: TextStyle(
              color: primaryColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Every concern deserves to be heard.',
          style: TextStyle(
            fontSize: 38,
            height: 1.15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF183B38),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'BayanSense helps residents report environmental '
          'and infrastructure concerns and helps organize '
          'them for appropriate barangay personnel.',
          style: TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Color(0xFF506660),
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: 210,
          child: AppButton(
            label: 'Get Started',
            icon: Icons.arrow_forward_rounded,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeroIllustration() {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.location_city_rounded,
          size: 115,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5ECE9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F3EF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 27,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183B38),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF647571),
            ),
          ),
        ],
      ),
    );
  }
}
