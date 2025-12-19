class MasterAppliance {
  final String id;
  final String category;
  final String subcategory;
  final String make;
  final String model;
  final String name;
  final String type;
  final String capacity;
  final double price;
  final double amcCost;
  final int amcDuration;
  final List<String> features;
  final String image;

  MasterAppliance({
    required this.id,
    required this.category,
    required this.subcategory,
    required this.make,
    required this.model,
    required this.name,
    required this.type,
    required this.capacity,
    required this.price,
    required this.amcCost,
    required this.amcDuration,
    required this.features,
    required this.image,
  });

  factory MasterAppliance.fromJson(Map<String, dynamic> json) {
    return MasterAppliance(
      id: json['id'],
      category: json['category'],
      subcategory: json['subcategory'],
      make: json['make'],
      model: json['model'],
      name: json['name'],
      type: json['type'],
      capacity: json['capacity'],
      price: json['price'].toDouble(),
      amcCost: json['amcCost'].toDouble(),
      amcDuration: json['amcDuration'],
      features: List<String>.from(json['features']),
      image: json['image'],
    );
  }
}

class UserAppliance {
  final String id;
  final String userId;
  final String applianceId;
  final String name;
  final String category;
  final String subcategory;
  final String make;
  final String model;
  final String serialNumber;
  final DateTime purchaseDate;
  final double purchasePrice;
  final DateTime warrantyEndDate;
  final DateTime? amcStartDate;
  final DateTime? amcEndDate;
  final String amcStatus;
  final String? amcProvider;
  final double? amcCost;
  final String? amcContactNumber;
  final DateTime? lastServiceDate;
  final DateTime? nextServiceDate;
  final int serviceCount;
  final String location;
  final DateTime installationDate;
  final String? notes;
  final double? rating;
  final String image;

  UserAppliance({
    required this.id,
    required this.userId,
    required this.applianceId,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.make,
    required this.model,
    required this.serialNumber,
    required this.purchaseDate,
    required this.purchasePrice,
    required this.warrantyEndDate,
    this.amcStartDate,
    this.amcEndDate,
    required this.amcStatus,
    this.amcProvider,
    this.amcCost,
    this.amcContactNumber,
    this.lastServiceDate,
    this.nextServiceDate,
    required this.serviceCount,
    required this.location,
    required this.installationDate,
    this.notes,
    this.rating,
    required this.image,
  });

  factory UserAppliance.fromJson(Map<String, dynamic> json) {
    return UserAppliance(
      id: json['id'],
      userId: json['userId'],
      applianceId: json['applianceId'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'],
      make: json['make'],
      model: json['model'],
      serialNumber: json['serialNumber'],
      purchaseDate: DateTime.parse(json['purchaseDate']),
      purchasePrice: json['purchasePrice'].toDouble(),
      warrantyEndDate: DateTime.parse(json['warrantyEndDate']),
      amcStartDate: json['amcStartDate'] != null ? DateTime.parse(json['amcStartDate']) : null,
      amcEndDate: json['amcEndDate'] != null ? DateTime.parse(json['amcEndDate']) : null,
      amcStatus: json['amcStatus'],
      amcProvider: json['amcProvider'],
      amcCost: json['amcCost']?.toDouble(),
      amcContactNumber: json['amcContactNumber'],
      lastServiceDate: json['lastServiceDate'] != null ? DateTime.parse(json['lastServiceDate']) : null,
      nextServiceDate: json['nextServiceDate'] != null ? DateTime.parse(json['nextServiceDate']) : null,
      serviceCount: json['serviceCount'],
      location: json['location'],
      installationDate: DateTime.parse(json['installationDate']),
      notes: json['notes'],
      rating: json['rating']?.toDouble(),
      image: json['image'],
    );
  }
}

class AMCStatusInfo {
  final String status;
  final int daysLeft;
  final String color;

  AMCStatusInfo({
    required this.status,
    required this.daysLeft,
    required this.color,
  });
}

class AMCStats {
  final int total;
  final int active;
  final int expiring;
  final int expired;
  final int pending;

  AMCStats({
    required this.total,
    required this.active,
    required this.expiring,
    required this.expired,
    required this.pending,
  });
}