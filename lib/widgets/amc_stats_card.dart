import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appliance_provider.dart';
import '../utils/theme.dart';

class AMCStatsCard extends StatelessWidget {
  const AMCStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplianceProvider>(
      builder: (context, provider, child) {
        final stats = provider.getAMCStats();
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AMC Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Total',
                        stats.total.toString(),
                        Colors.blue,
                        Icons.devices,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'Active',
                        stats.active.toString(),
                        AppTheme.activeColor,
                        Icons.check_circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Expiring',
                        stats.expiring.toString(),
                        AppTheme.expiringColor,
                        Icons.warning,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'Expired',
                        stats.expired.toString(),
                        AppTheme.expiredColor,
                        Icons.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}