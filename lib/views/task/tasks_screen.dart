import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/app_header.dart';
import '../widgets/create_task_modal.dart';
import '../widgets/task_item_widget.dart';
import '../../utils/app_colors.dart';
import '../../models/task_model.dart';

class TaskScreen extends StatefulWidget{
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String selectedPriority = "All Priorities";
  bool showDropdown = false;
  bool showClearDropdown = false;
  List<TaskGroup> taskGroups = [];
  bool showCompletedTasks = false;

  @override
  void initState() {
    super.initState();
    _loadTaskGroups();
  }

  void _loadTaskGroups() {
    final tasks = TaskModel.getSampleTasks();
    final Map<String, List<TaskModel>> groupedTasks = {};
    
    for (var task in tasks) {
      if (!showCompletedTasks && task.isCompleted) continue;
      
      if (groupedTasks.containsKey(task.assignedTo)) {
        groupedTasks[task.assignedTo]!.add(task);
      } else {
        groupedTasks[task.assignedTo] = [task];
      }
    }
    
    taskGroups = groupedTasks.entries.map((entry) {
      return TaskGroup(
        name: entry.key == "Unassigned" ? "Unassigned Tasks" : "${entry.key}'s Tasks",
        avatar: entry.key == "Unassigned" ? "?" : entry.key.split(' ').first[0],
        tasks: entry.value,
        isExpanded: entry.key == "Unassigned" || entry.key == "Evie Walton",
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(),
          //SizedBox(height: MediaQuery.of(context).size.height * 0.047),

          
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  // Page Title Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/pencil_icon.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Family Tasks",
                          style: TextStyle(
                            fontFamily: 'Prompt_Bold',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF413B3F),
                          )
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 8.h),
                  
                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Manage and assign tasks for the whole family",
                      style: TextStyle(
                        fontFamily: 'Prompt_regular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subHeadingColor,
                      )
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Main Content Card
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFF757575).withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.08),
                          offset: const Offset(4, 0),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],

                      // boxShadow: [
                      //   BoxShadow(
                      //     color: const Color(0xFF000000).withOpacity(0.08),
                      //     offset: const Offset(4, 0),
                      //     blurRadius: 4,
                      //     spreadRadius: 0,
                      //   ),
                      // ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    // Advanced Task Management Section
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/flag.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Advanced Task Management",
                          style: TextStyle(
                            fontFamily: 'Prompt_Bold',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          )
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Add and Clear Buttons
                    Row(
                      children: [
                        // Add Button
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
                                  showDialog(
                                    context: context,
                                    builder: (context) => const CreateTaskModal(),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        //fontFamily: 'Prompt_Bold',
                                        fontFamily: 'Prompt_regular',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 12.w),
                        
                        // Clear Button
                        Expanded(
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showClearDropdown = !showClearDropdown;
                                  });
                                },
                                borderRadius: BorderRadius.circular(12.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Clear",
                                      style: TextStyle(
                                        fontFamily: 'Prompt_regular',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      showClearDropdown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Clear Dropdown Options
                    if (showClearDropdown)
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildClearDropdownOption("Clear My Tasks", Icons.delete_outline, false),
                            _buildClearDropdownOption("Clear Teen Tasks", Icons.group, false),
                            _buildClearDropdownOption("Clear Child Tasks", Icons.person, false),
                            _buildClearDropdownOption("Clear All Manageable", Icons.delete_outline, true),
                          ],
                        ),
                      ),
                    
                    SizedBox(height: 24.h),

                    Text("Task Summary", style: TextStyle(
                      fontFamily: 'Prompt_regular', 
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    )),
                    SizedBox(height: 16.h),
                    
                    // Task Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildTaskSummaryCard(
                            "My Tasks",
                            doneCount: _getMyTasksDoneCount(),
                            dueCount: _getMyTasksDueCount(),
                            iconColor: const Color(0xFF3B82F6),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTaskSummaryCard(
                            "Family Tasks",
                            doneCount: _getFamilyTasksDoneCount(),
                            dueCount: _getFamilyTasksDueCount(),
                            iconColor: const Color(0xFF8B5CF6),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Search Bar
                    Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search tasks...",
                          hintStyle: TextStyle(
                            fontFamily: 'Prompt_regular',
                            fontSize: 14.sp,
                            color: AppColors.subHeadingColor,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.subHeadingColor,
                            size: 20.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Filter Dropdown
                    Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showDropdown = !showDropdown;
                            });
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.filter_list,
                                  color: AppColors.subHeadingColor,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  selectedPriority,
                                  style: TextStyle(
                                    fontFamily: 'Prompt_regular',
                                    fontSize: 12.sp,
                                    color: AppColors.textColor,
                                  )
                                ),
                                const Spacer(),
                                Icon(
                                  showDropdown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: AppColors.subHeadingColor,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Dropdown Options
                    if (showDropdown)
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildDropdownOption("All Priorities"),
                            _buildDropdownOption("High"),
                            _buildDropdownOption("Medium"),
                            _buildDropdownOption("Low"),
                          ],
                        ),
                      ),
                    
                    SizedBox(height: 16.h),
                    
                    // Show completed tasks checkbox
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showCompletedTasks = !showCompletedTasks;
                              _loadTaskGroups();
                            });
                          },
                          child: Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: showCompletedTasks ? AppColors.primary : const Color(0xFFE5E7EB),
                                width: 2,
                              ),
                              color: showCompletedTasks ? AppColors.primary : Colors.transparent,
                            ),
                            child: showCompletedTasks
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12.sp,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Show completed tasks",
                          style: TextStyle(
                            fontFamily: 'Prompt_regular',
                            fontSize: 14.sp,
                            color: AppColors.textColor,
                          )
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Task Groups
                    if (taskGroups.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              color: AppColors.subHeadingColor,
                              size: 48.sp,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No tasks found",
                              style: TextStyle(
                                fontFamily: 'Prompt_Bold',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor,
                              )
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Try adjusting your filters or create a new task.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Prompt_regular',
                                fontSize: 14.sp,
                                color: AppColors.subHeadingColor,
                              )
                            ),
                          ],
                        ),
                      )
                    else
                      ...taskGroups.map((group) => _buildTaskGroupCard(group)).toList(),
                    
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
  
  // Helper methods to calculate task counts
  int _getMyTasksDoneCount() {
    final tasks = TaskModel.getSampleTasks();
    return tasks.where((task) => task.isPrivate && task.isCompleted).length;
  }

  int _getMyTasksDueCount() {
    final tasks = TaskModel.getSampleTasks();
    return tasks.where((task) => task.isPrivate && !task.isCompleted).length;
  }

  int _getFamilyTasksDoneCount() {
    final tasks = TaskModel.getSampleTasks();
    return tasks.where((task) => !task.isPrivate && task.isCompleted).length;
  }

  int _getFamilyTasksDueCount() {
    final tasks = TaskModel.getSampleTasks();
    return tasks.where((task) => !task.isPrivate && !task.isCompleted).length;
  }

  // Build task summary card
  Widget _buildTaskSummaryCard(String title, {required int doneCount, required int dueCount, required Color iconColor}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Container(
              //   width: 40.w,
              //   height: 40.h,
              //   decoration: BoxDecoration(
              //     color: iconColor.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(8.r),
              //   ),
              //   child: Center(
              //     child: Icon(
              //       title == "My Tasks" ? Icons.person : Icons.people,
              //       color: iconColor,
              //       size: 20.sp,
              //     ),
              //   ),
              // ),
              // SizedBox(width: 8.w),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Prompt_Bold',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem("Due", doneCount.toString(), const Color(0xFF10B981)),
              SizedBox(width: 8.w),
              _buildSummaryItem("Ongoing", dueCount.toString(), const Color(0xFF3B82F6)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String count, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count,
            style: TextStyle(
              fontFamily: 'Prompt_Bold',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDropdownOption(String option) {
    bool isSelected = selectedPriority == option;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPriority = option;
            showDropdown = false;
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            option,
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              color: isSelected ? Colors.white : AppColors.textColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildClearDropdownOption(String option, IconData icon, bool isSpecial) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            showClearDropdown = false;
          });
          // Handle clear action here
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSpecial ? const Color(0xFFEF4444) : AppColors.textColor,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                option,
                style: TextStyle(
                  fontFamily: 'Prompt_regular',
                  fontSize: 14.sp,
                  color: isSpecial ? const Color(0xFFEF4444) : AppColors.textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskGroupCard(TaskGroup group) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.08),
            offset: const Offset(4, 0),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Group Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: group.avatar == "?" ? const Color(0xFF9CA3AF) : AppColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      group.avatar,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Group Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: TextStyle(
                          fontFamily: 'Prompt_Bold',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                      Text(
                        "${group.tasks.length} task${group.tasks.length != 1 ? 's' : ''}",
                        style: TextStyle(
                          fontFamily: 'Prompt_regular',
                          fontSize: 13.sp,
                          color: AppColors.subHeadingColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Action Icons
                Row(
                  children: [
                    Icon(
                      Icons.print,
                      color: AppColors.subHeadingColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          group.isExpanded = !group.isExpanded;
                        });
                      },
                      child: Icon(
                        group.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                        color: AppColors.subHeadingColor,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Task List (if expanded)
          if (group.isExpanded)
            ...group.tasks.map((task) => TaskItemWidget(
              task: task,
              onToggleComplete: () {
                setState(() {
                  // Toggle task completion
                });
              },
              onEdit: () {
                // Handle edit
              },
              onDelete: () {
                // Handle delete
              },
            )).toList(),
        ],
      ),
    );
  }

}