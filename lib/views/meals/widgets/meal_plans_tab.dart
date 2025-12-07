import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../add_meal_modal.dart';

class MealPlansTab extends StatelessWidget {
  final List<String> days;
  final List<String> mealTypes;
  final Map<String, List<Map<String, String>>> mealPlan;
  final Function(String day, int index) onDeleteMeal;
  final void Function() onShowAddMealDialog;

  const MealPlansTab({
    super.key,
    required this.days,
    required this.mealTypes,
    required this.mealPlan,
    required this.onDeleteMeal,
    required this.onShowAddMealDialog,
  });

  List<Widget> _buildIngredientList(String ingredientsString) {
    if (ingredientsString.isEmpty) return [const SizedBox.shrink()];

    final ingredients = ingredientsString.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

    return [
      const SizedBox(height: 8),
      ...ingredients.map((item) => Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
        child: Text(
          '• $item',
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
        ),
      )).toList(),
      const SizedBox(height: 8),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== MEAL PLAN TAB (CONTENT) =====
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Weekly Meal Plan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => onShowAddMealDialog(),
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text(
                "Add Meal",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Column(
          children: days.map((day) {
            final meals = mealPlan[day]!;
            return DayCard(
              day: day,
              meals: meals,
              onDeleteMeal: onDeleteMeal,
              buildIngredientList: _buildIngredientList,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DayCard extends StatelessWidget {
  final String day;
  final List<Map<String, String>> meals;
  final Function(String day, int index) onDeleteMeal;
  final Function(String) buildIngredientList;

  const DayCard({
    super.key,
    required this.day,
    required this.meals,
    required this.onDeleteMeal,
    required this.buildIngredientList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Name
          Center(
            child: Text(day,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark)),
          ),
          const SizedBox(height: 12),
          if (meals.isEmpty)
          // Empty state text centered
            Center(
              child: const Text("No meals planned",
                  style: TextStyle(
                      fontSize: 14, color: AppColors.grey))
            )
          else
          // --- MEAL ITEM LIST ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return MealItemCard(
                  meal: meal,
                  onDelete: () => onDeleteMeal(day, index),
                  buildIngredientList: buildIngredientList,
                );
              },
            ),
        ],
      ),
    );
  }
}

class MealItemCard extends StatelessWidget {
  final Map<String, String> meal;
  final VoidCallback onDelete;
  final Function(String) buildIngredientList;

  const MealItemCard({
    super.key,
    required this.meal,
    required this.onDelete,
    required this.buildIngredientList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Meal Type Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    meal['type']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                // Delete Icon
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.delete, size: 18, color: AppColors.grey),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Meal Name
            Text(
              meal['name']!,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),

            // Ingredients List
            if (meal['ingredients']!.isNotEmpty)
              ...buildIngredientList(meal['ingredients']!),
          ],
        ),
      ),
    );
  }
}
