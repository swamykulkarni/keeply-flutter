import 'package:flutter/material.dart';
import '../models/appliance.dart';
import '../data/sample_data.dart';

class ApplianceProvider with ChangeNotifier {
  List<MasterAppliance> _masterAppliances = [];
  List<UserAppliance> _userAppliances = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<MasterAppliance> get masterAppliances => _masterAppliances;
  List<UserAppliance> get userAppliances => _userAppliances;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  ApplianceProvider() {
    _loadData();
  }

  void _loadData() {
    _masterAppliances = SampleData.getMasterAppliances();
    _userAppliances = SampleData.getUserAppliances();
    notifyListeners();
  }

  List<MasterAppliance> get filteredMasterAppliances {
    List<MasterAppliance> filtered = _masterAppliances;

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((appliance) => 
        appliance.category == _selectedCategory).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((appliance) =>
        appliance.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        appliance.make.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        appliance.model.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  AMCStatusInfo getAMCStatus(UserAppliance appliance) {
    final today = DateTime.now();
    
    if (appliance.amcEndDate == null) {
      return AMCStatusInfo(status: 'PENDING', daysLeft: 0, color: 'grey');
    }
    
    final daysUntilExpiry = appliance.amcEndDate!.difference(today).inDays;
    
    if (daysUntilExpiry < 0) {
      return AMCStatusInfo(
        status: 'EXPIRED', 
        daysLeft: daysUntilExpiry.abs(), 
        color: 'red'
      );
    } else if (daysUntilExpiry <= 30) {
      return AMCStatusInfo(
        status: 'EXPIRING', 
        daysLeft: daysUntilExpiry, 
        color: 'orange'
      );
    } else {
      return AMCStatusInfo(
        status: 'ACTIVE', 
        daysLeft: daysUntilExpiry, 
        color: 'green'
      );
    }
  }

  AMCStats getAMCStats() {
    int active = 0, expiring = 0, expired = 0, pending = 0;
    
    for (var appliance in _userAppliances) {
      final status = getAMCStatus(appliance);
      switch (status.status) {
        case 'ACTIVE':
          active++;
          break;
        case 'EXPIRING':
          expiring++;
          break;
        case 'EXPIRED':
          expired++;
          break;
        case 'PENDING':
          pending++;
          break;
      }
    }
    
    return AMCStats(
      total: _userAppliances.length,
      active: active,
      expiring: expiring,
      expired: expired,
      pending: pending,
    );
  }

  List<UserAppliance> getAppliancesByStatus(String status) {
    return _userAppliances.where((appliance) {
      final amcStatus = getAMCStatus(appliance);
      return amcStatus.status == status;
    }).toList();
  }

  List<UserAppliance> getExpiringAppliances({int days = 30}) {
    return _userAppliances.where((appliance) {
      final amcStatus = getAMCStatus(appliance);
      return amcStatus.status == 'EXPIRING' && amcStatus.daysLeft <= days;
    }).toList();
  }

  void addUserAppliance(MasterAppliance masterAppliance) {
    final newUserAppliance = UserAppliance(
      id: 'ua${DateTime.now().millisecondsSinceEpoch}',
      userId: 'demo_user',
      applianceId: masterAppliance.id,
      name: masterAppliance.name,
      category: masterAppliance.category,
      subcategory: masterAppliance.subcategory,
      make: masterAppliance.make,
      model: masterAppliance.model,
      serialNumber: 'SN${DateTime.now().millisecondsSinceEpoch}',
      purchaseDate: DateTime.now(),
      purchasePrice: masterAppliance.price,
      warrantyEndDate: DateTime.now().add(const Duration(days: 365)),
      amcStartDate: DateTime.now().add(const Duration(days: 366)),
      amcEndDate: DateTime.now().add(const Duration(days: 731)),
      amcStatus: 'PENDING',
      amcProvider: '${masterAppliance.make} Service Center',
      amcCost: masterAppliance.amcCost,
      amcContactNumber: '+91-9876543210',
      serviceCount: 0,
      location: 'Home',
      installationDate: DateTime.now(),
      notes: 'Recently added appliance',
      image: masterAppliance.image,
    );
    
    _userAppliances.add(newUserAppliance);
    notifyListeners();
  }
}