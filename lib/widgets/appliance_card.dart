import 'package:flutter/material.dart';
import '../utils/theme.dart';

class ApplianceCard extends StatelessWidget {
  final dynamic appliance;
  final dynamic status;
  final VoidCallback? onTap;

  const ApplianceCard({
    super.key,
    required this.appliance,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.getStatusColor(status.status).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              // Appliance Image
              Container(
                width: 60,
                height: 60,
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
              
              const SizedBox(width: 16),
              
              // Appliance Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appliance.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${appliance.make} • ${appliance.location}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getStatusColor(status.status)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getStatusText(status),
                            style: TextStyle(
                              color: AppTheme.getStatusColor(status.status),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (appliance.rating != null) ...[
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber[600],
                              ),
                              const SizedBox(width: 2),
                              Text(
                                appliance.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              
              // Status Icon and Arrow
              Column(
                children: [
                  Icon(
                    _getStatusIcon(status.status),
                    color: AppTheme.getStatusColor(status.status),
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
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