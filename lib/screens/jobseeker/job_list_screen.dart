import 'package:flutter/material.dart';
import 'job_detail_screen.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🚀 Expanded and powerful job list
    final jobs = [
      // Blue Collar Jobs
      "Construction Worker",
      "General Worker",
      "Welder",
      "Metal Worker",
      "Lathe Operator",
      "Carpenter",
      "Bricklayer",
      "Painter",
      "Plumber",
      "Electrician",
      "Boilermaker",
      "Mechanic",
      "Machine Operator",
      "Forklift Driver",
      "Warehouse Worker",
      "Packer",
      "Loader",
      "Delivery Assistant",

      // Landscaping & Outdoor Work
      "Landscaper",
      "Garden Worker",
      "Lawn Mower Operator",
      "Yard Cleaner",
      "Tree Cutter",
      "Hedge Trimmer",
      "Irrigation Worker",
      "Grass Cutter",
      "Groundskeeper",

      // Construction Finishing
      "Plasterer",
      "Tiler",
      "Ceiling Installer",
      "Flooring Installer",
      "Roofer",
      "Paving Worker",
      "Concrete Worker",
      "Scaffolder",

      // Cleaning & Services
      "Cleaner",
      "Car Washer",
      "Mobile Car Wash",
      "Window Cleaner",
      "Pressure Cleaner",
      "Building Cleaner",
      "Office Cleaner",
      "Industrial Cleaner",

      // Handyman Services
      "Handyman",
      "General Maintenance",
      "Property Maintenance",
      "Repair Technician",
      "Maintenance Assistant",

      // Transport
      "Driver",
      "Truck Driver",
      "Taxi Driver",
      "Bus Driver",
      "Courier Driver",
      "Delivery Driver",

      // Security
      "Security Guard",
      "Control Room Operator",
      "Security Supervisor",

      // Healthcare
      "Nursing Assistant",
      "Home Care Worker",
      "Caregiver",
      "Hospital Cleaner",
      "Clinic Receptionist",
      "Health Care Assistant",

      // Office & Admin
      "Admin Clerk",
      "Receptionist",
      "Office Assistant",
      "Data Capturer",
      "Call Center Agent",
      "Office Cleaner",

      // Retail
      "Shop Assistant",
      "Cashier",
      "Storeman",
      "Sales Assistant",
      "Shelf Packer",

      // Hospitality & Kitchen
      "Chef",
      "Cook",
      "Pastry Chef",
      "Kitchen Assistant",
      "Waiter",
      "Baker",
      "Catering Assistant",
      "Dishwasher",
      "Restaurant Manager",
      "Food Preparation Worker",

      // Fishing & Marine
      "Fisherman",
      "Fishing Crew Member",
      "Boat Worker",
      "Deckhand",
      "Harbour Worker",

      // Mining
      "Mine Worker",
      "Mine General Worker",
      "Drill Operator",
      "Mine Machine Operator",
      "Underground Worker",
      "Miner Assistant",

      // Upholstery & Furniture
      "Upholsterer",
      "Furniture Maker",
      "Furniture Assembler",
      "Couch Repair Worker",

      // Government Jobs
      "Municipal Worker",
      "Traffic Officer",
      "Home Affairs Clerk",
      "Government Admin",
      "Public Works Worker",

      // Technical & Professional
      "IT Support",
      "Software Developer",
      "Network Technician",
      "Engineer",
      "Technician",
      "Electric Technician",

      // Education
      "Teacher Assistant",
      "School Admin",
      "Tutor",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Jobs"),
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.work_outline, size: 20),
              ),
              title: Text(
                jobs[index],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobDetailScreen(jobTitle: jobs[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
