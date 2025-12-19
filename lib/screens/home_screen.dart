import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appliance_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/amc_stats_card.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/recent_appliances_card.dart';
import '../widgets/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keeply AMC Tracker'),
        actions: [
          Consumer<ApplianceProvider>(
            builder: (context, provider, child) {
              final expiringCount = provider.getExpiringAppliances().length;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      _showNotifications(context, provider);
                    },
                  ),
                  if (expiringCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$expiringCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _handleLogout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildMyAppliancesTab(),
          _buildBrowseTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Text(
                'Hello, ${authProvider.userName ?? 'User'}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s your AMC overview',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          
          // AMC Statistics
          const AMCStatsCard(),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          const QuickActionsCard(),
          
          const SizedBox(height: 24),
          
          // Recent Appliances
          const RecentAppliancesCard(),
        ],
      ),
    );
  }

  Widget _buildMyAppliancesTab() {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const MyAppliancesScreen(),
        );
      },
    );
  }

  Widget _buildBrowseTab() {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const BrowseAppliancesScreen(),
        );
      },
    );
  }

  Widget _buildProfileTab() {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      },
    );
  }

  void _showNotifications(BuildContext context, ApplianceProvider provider) {
    final expiringAppliances = provider.getExpiringAppliances();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AMC Notifications'),
        content: expiringAppliances.isEmpty
            ? const Text('No pending notifications')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: expiringAppliances.map((appliance) {
                  final status = provider.getAMCStatus(appliance);
                  return ListTile(
                    leading: const Icon(Icons.warning, color: Colors.orange),
                    title: Text(appliance.name),
                    subtitle: Text('AMC expires in ${status.daysLeft} days'),
                  );
                }).toList(),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

