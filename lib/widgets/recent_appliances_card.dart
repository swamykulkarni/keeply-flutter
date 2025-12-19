import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appliance_provider.dart';
import '../utils/theme.dart';
import 'package:intl/intl.dart';

class RecentAppliancesCard extends StatelessWidget {
  const RecentAppliancesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplianceProvider>(
      builder: (context, provider, child) {
        final recentAppliances = provider.userAppliances.take(4).toList();
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Appliances',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to My Appliances tab
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Use My Appliances tab to see all'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (recentAppliances.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No appliances added yet.\nStart by browsing and adding appliances!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ...recentAppliances.map((appliance) {
                    final status = provider.getAMCStatus(appliance);
                    return _buildApplianceItem(appliance, status);
                  }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildApplianceItem(appliance, status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getStatusColor(status.status).withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Appliance Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                appliance.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.devices,
                    color: Colors.grey[400],
                    size: 30,
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Appliance Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appliance.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${appliance.make} • ${appliance.location}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getStatusColor(status.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getStatusText(status),
                        style: TextStyle(
                          color: AppTheme.getStatusColor(status.status),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Status Icon
          Icon(
            _getStatusIcon(status.status),
            color: AppTheme.getStatusColor(status.status),
            size: 20,
          ),
        ],
      ),
    );
  }

  String _getStatusText(status) {
    switch (status.status) {
      case 'ACTIVE':
        return '${status.daysLeft} days left';
      case 'EXPIRING':
        return 'Expires in ${status.daysLeft} days';
      case 'EXPIRED':
        return 'Expired ${status.daysLeft} days ago';
      case 'PENDING':
        return 'Under warranty';
      default:
        return 'Unknown';
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'ACTIVE':
        return Icons.check_circle;
      case 'EXPIRING':
        return Icons.warning;
      case 'EXPIRED':
        return Icons.error;
      case 'PENDING':
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }
}