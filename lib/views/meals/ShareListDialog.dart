import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../widgets/custom_dropdown.dart';


class ShareListDialog extends StatefulWidget {
  final List<Map<String, dynamic>> itemsToShare;

  final List<Map<String, String>> familyMembers = const [
    {'id': 'emily_w', 'name': 'Emily Walton', 'role': 'parent'},
    {'id': 'ti_w', 'name': 'Ti Walton', 'role': 'parent'},
    {'id': 'adri_s', 'name': 'Adri Walton', 'role': 'sibling'},
    {'id': 'evie_c', 'name': 'Evie Walton', 'role': 'child'},
  ];

  const ShareListDialog({
    super.key,
    required this.itemsToShare,
  });

  @override
  State<ShareListDialog> createState() => _ShareListDialogState();
}

class _ShareListDialogState extends State<ShareListDialog> {
  String? selectedMember;

  @override
  void initState() {
    super.initState();

    selectedMember = null;
  }

  @override
  Widget build(BuildContext context) {
    // Condition for enabling the Share List button
    final bool canShare =
        selectedMember != null &&
            widget.itemsToShare.isNotEmpty;

    return AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.only(top: 24, left: 24, right: 10),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Edit Existing Text Note',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textDark),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Send to:', style: TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),

            // Dropdown Field (Matching image design)
            CustomDropdown<String>(
              items: widget.familyMembers.map((member) {
                return DropdownItem(
                  value: member['id']!,
                  label: '${member['name']} (${member['role']})',
                );
              }).toList(),
              value: selectedMember,
              onChanged: (String? value) {
                setState(() {
                  selectedMember = value;
                });
              },
              hintText: 'Choose family member',
            ),
            const SizedBox(height: 24),

            Text('Items to share (${widget.itemsToShare.length} items)',
                style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 12),

            // Items Container (Matching image design)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey.withOpacity(0.5)),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: widget.itemsToShare.isEmpty
                    ? [const Text("No items to share", style: TextStyle(color: AppColors.grey))]
                    : widget.itemsToShare.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['name'], style: const TextStyle(fontSize: 15, color: AppColors.textDark)),
                        Text('${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel Button (Outlined style)
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.grey, width: 0.5),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 16),

            // Share List Button (Solid Pink with Send Icon)
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: canShare ? AppColors.primary : AppColors.primary.withOpacity(0.5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: canShare
                    ? () {
                  print('Sharing list to member: $selectedMember');
                  Navigator.pop(context);
                }
                    : null,
                icon: const Icon(Icons.send, size: 20),
                label: const Text('Share List', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}