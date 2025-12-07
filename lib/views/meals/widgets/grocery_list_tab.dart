import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_dropdown.dart';

class GroceryListTab extends StatefulWidget {
  final List<String> groceryCategories;

  const GroceryListTab({
    super.key,
    required this.groceryCategories,
  });

  @override
  State<GroceryListTab> createState() => _GroceryListTabState();
}

class _GroceryListTabState extends State<GroceryListTab> {
  String? _selectedCategory;
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    itemNameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== GROCERY LIST TAB (CONTENT) =====
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: const Color(0xFF757575).withOpacity(0.2)),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement "From Meals" functionality
                },
                icon: const Icon(Icons.calendar_today, size: 16, color: AppColors.textDark),
                label: const Text(
                  "From Meals",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: const Color(0xFF757575).withOpacity(0.2)),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement "Share" functionality
                },
                icon: const Icon(Icons.share_outlined, size: 16, color: AppColors.textDark),
                label: const Text(
                  "Share",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Item Name Input (Full Width)
        TextField(
          controller: itemNameController,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: "Item name",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: const Color(0xFF757575).withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: const Color(0xFF757575).withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            hintStyle: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 12),
        
        // Quantity, Category, Add Icon (One Line)
        Row(
          children: [
            // Quantity Input
            Expanded(
              child: TextField(
                controller: quantityController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Quantity",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFF757575).withOpacity(0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFF757575).withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  hintStyle: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Category Dropdown
            Expanded(
              child: CustomDropdown<String>(
                items: widget.groceryCategories.toDropdownItems((item) => item),
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                hintText: "Category",
              ),
            ),
            const SizedBox(width: 8),
            // Add Button
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Add item to grocery list
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Shopping List Status
        Row(
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.textDark,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Shopping List (0 items)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Empty State
        Center(
          child: Text(
            "All items completed!",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
