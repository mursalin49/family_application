import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_date_picker.dart';
import 'custom_time_picker.dart';
import 'custom_dropdown.dart';
import '../../utils/app_colors.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _dueTimeController = TextEditingController();

  String selectedPriority = "";
  String selectedAssignTo = "";
  String selectedPointsReward = "None (No Points)";
  bool isPrivateTask = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    _dueTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  _buildTitleField(),
                  _buildDescriptionField(),
                  _buildPriorityAndAssignToRow(),
                  _buildPointsRewardField(),
                  _buildPrivateTaskField(),
                  _buildDueDateAndTimeRow(),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header Widget
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Create New Task",
          style: TextStyle(
            fontFamily: 'Prompt_Bold',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.close,
            color: AppColors.textColor,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  // Title Field Widget
  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(
          "Title *",
          style: TextStyle(
            fontFamily: 'Prompt_Bold',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _titleController,
          hintText: "Enter your title",
        ),
      ],
    );
  }

  // Description Field Widget
  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          "Description",
          style: TextStyle(
            fontFamily: 'Prompt_Bold',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _descriptionController,
          hintText: "Enter task description",
          maxLines: 3,
        ),
      ],
    );
  }

  // Priority and Assign To Row Widget
  Widget _buildPriorityAndAssignToRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            // Priority
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Priority",
                    style: TextStyle(
                      fontFamily: 'Prompt_Bold',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomDropdown<String>(
                    value: selectedPriority.isEmpty ? null : selectedPriority,
                    hintText: "Select",
                    items: [
                      "High Priority",
                      "Medium Priority", 
                      "Low Priority",
                    ].toDropdownItems((item) => item),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPriority = newValue ?? "";
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Assign To
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assign To",
                    style: TextStyle(
                      fontFamily: 'Prompt_Bold',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomDropdown<String>(
                    value: selectedAssignTo.isEmpty ? null : selectedAssignTo,
                    hintText: "Select",
                    prefixIcon: Icon(
                      Icons.filter_list,
                      color: AppColors.textColor,
                      size: 20.sp,
                    ),
                    items: [
                      "Unassigned",
                      "Emily Walton (parent)",
                      "TJ Walton (parent)",
                      "Adri Walton (teen)",
                      "Evie Walton (child)",
                    ].toDropdownItems((item) => item),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAssignTo = newValue ?? "";
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Points Reward Field Widget
  Widget _buildPointsRewardField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          "Points Reward",
          style: TextStyle(
            fontFamily: 'Prompt_Bold',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        CustomDropdown<String>(
          value: selectedPointsReward.isEmpty ? null : selectedPointsReward,
          hintText: "Select Points",
          items: [
            "None (No Points)",
            "5 Points",
            "10 Points",
            "15 Points",
            "20 Points",
            "25 Points",
            "30 Points",
            "50 Points",
          ].toDropdownItems((item) => item),
          onChanged: (String? newValue) {
            setState(() {
              selectedPointsReward = newValue ?? "";
            });
          },
        ),
      ],
    );
  }

  // Private Task Field Widget
  Widget _buildPrivateTaskField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(
              Icons.lock,
              color: AppColors.textColor,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Private Task",
                    style: TextStyle(
                      fontFamily: 'Prompt_Bold',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    "Only you can see this task",
                    style: TextStyle(
                      fontFamily: 'Prompt_regular',
                      fontSize: 12.sp,
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isPrivateTask,
              onChanged: (value) {
                setState(() {
                  isPrivateTask = value;
                });
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }

  // Due Date and Time Row Widget
  Widget _buildDueDateAndTimeRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            // Due Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Date",
                    style: TextStyle(
                      fontFamily: 'Prompt_Bold',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDatePicker(
                          selectedDate: selectedDate,
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                              _dueDateController.text = "${date.day}/${date.month}/${date.year}";
                            });
                          },
                          onClose: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    child: _buildTextField(
                      controller: _dueDateController,
                      hintText: "Pick Date",
                      prefixIcon: Icons.calendar_today,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Due Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Time",
                    style: TextStyle(
                      fontFamily: 'Prompt_Bold',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomTimePicker(
                          selectedTime: selectedTime,
                          onTimeSelected: (time) {
                            setState(() {
                              selectedTime = time;
                              _dueTimeController.text = time.format(context);
                            });
                          },
                          onClose: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    child: _buildTextField(
                      controller: _dueTimeController,
                      hintText: "--:--",
                      suffixIcon: Icons.access_time,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Action Buttons Widget
  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Row(
          children: [
            // Cancel Button
            Expanded(
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: 'Prompt_regular',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Create Task Button
            Expanded(
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Handle create task
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Center(
                      child: Text(
                        "Create Task",
                        style: TextStyle(
                          fontFamily: 'Prompt_regular',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Prompt_regular',
            fontSize: 14.sp,
            color: AppColors.subHeadingColor,
          ),
          prefixIcon: prefixIcon != null ? Icon(
            prefixIcon,
            color: AppColors.textColor,
            size: 20.sp,
          ) : null,
          suffixIcon: suffixIcon != null ? Icon(
            suffixIcon,
            color: AppColors.textColor,
            size: 20.sp,
          ) : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }


}
