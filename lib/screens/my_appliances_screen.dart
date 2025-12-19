import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appliance_provider.dart';
import '../utils/theme.dart';
import '../widgets/appliance_card.dart';

class MyAppliancesScreen extends StatefulWidget {
  const MyAppliancesScreen({super.key});

  @override
  State<MyAppliancesScreen> createState() => _MyAppliancesScreenState();
}

class _MyAppliancesScreenState extends State<MyAppliancesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Active'),
                Tab(text: 'Expiring'),
                Tab(text: 'Expired'),
                Tab(text: 'Pending'),
              ],
            ),
          ),
          
          // Tab Views
          Expanded(
            child: Consumer<ApplianceProvider>(
              builder: (context, provider, child) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAppliancesList(provider.userAppliances, provider),
                    _buildAppliancesList(
                      provider.getAppliancesByStatus('ACTIVE'),
                      provider,
                    ),
                    _buildAppliancesList(
                      provider.getAppliancesByStatus('EXPIRING'),
                      provider,
                    ),
                    _buildAppliancesList(
                      provider.getAppliancesByStatus('EXPIRED'),
                      provider,
                    ),
                    _buildAppliancesList(
                      provider.getAppliancesByStatus('PENDING'),
                      provider,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppliancesList(List appliances, ApplianceProvider provider) {
    if (appliances.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.devices_other,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No appliances found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add appliances to start tracking AMCs',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appliances.length,
      itemBuilder: (context, index) {
        final appliance = appliances[index];
        final status = provider.getAMCStatus(appliance);
        
        return ApplianceCard(
          appliance: appliance,
          status: status,
          onTap: () => _showApplianceDetails(appliance, status),
        );
      },
    );
  }

  void _showApplianceDetails(appliance, status) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Appliance Image and Name
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            appliance.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.devices,
                                color: Colors.grey[400],
                                size: 40,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appliance.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${appliance.make} • ${appliance.model}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.getStatusColor(status.status)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                status.status,
                                style: TextStyle(
                                  color: AppTheme.getStatusColor(status.status),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Details sections
                  _buildDetailSection('Basic Information', [
                    _buildDetailRow('Serial Number', appliance.serialNumber),
                    _buildDetailRow('Location', appliance.location),
                    _buildDetailRow('Category', appliance.category),
                    _buildDetailRow('Purchase Price', '₹${appliance.purchasePrice.toStringAsFixed(0)}'),
                  ]),
                  
                  const SizedBox(height: 16),
                  
                  _buildDetailSection('AMC Information', [
                    _buildDetailRow('AMC Provider', appliance.amcProvider ?? 'N/A'),
                    _buildDetailRow('AMC Cost', appliance.amcCost != null ? '₹${appliance.amcCost!.toStringAsFixed(0)}' : 'N/A'),
                    _buildDetailRow('Contact Number', appliance.amcContactNumber ?? 'N/A'),
                    _buildDetailRow('Service Count', appliance.serviceCount.toString()),
                  ]),
                  
                  if (appliance.notes != null) ...[
                    const SizedBox(height: 16),
                    _buildDetailSection('Notes', [
                      Text(
                        appliance.notes!,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ]),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Edit feature coming soon!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Service booking coming soon!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.build),
                          label: const Text('Book Service'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}