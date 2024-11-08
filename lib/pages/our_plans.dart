import 'package:flutter/material.dart';
import 'package:studie/pages/plan.dart';

class OurPlansPage extends StatelessWidget {
  const OurPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of plans
    final List<Plan> plans = [
      Plan(
        title: 'Free Plan',
        description:
            '• 5 transcriptions per month\n• Basic transcription features',
        actionButtonText: 'Select',
        onPressed: () {
          // Handle Free Plan selection
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Free Plan selected')),
          );
        },
      ),
      Plan(
        title: 'Premium Plan',
        description:
            '• Unlimited transcriptions\n• Fast processing\n• Advanced punctuation',
        actionButtonText: 'Select',
        onPressed: () {
          // Handle Premium Plan selection
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Premium Plan selected')),
          );
        },
      ),
      Plan(
        title: 'Enterprise Plan',
        description: '• Custom pricing\n• API integration\n• 24/7 support',
        actionButtonText: 'Contact Us',
        onPressed: () {
          // Handle Enterprise Plan contact
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Enterprise Plan selected')),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Plans'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return PlanTile(plan: plan);
        },
      ),
    );
  }
}

class PlanTile extends StatelessWidget {
  final Plan plan;

  const PlanTile({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          plan.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(plan.description),
        trailing: ElevatedButton(
          onPressed: plan.onPressed,
          child: Text(plan.actionButtonText),
        ),
      ),
    );
  }
}
