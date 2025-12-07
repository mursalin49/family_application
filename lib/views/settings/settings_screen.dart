import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../widgets/app_header.dart';
import '../widgets/custom_dropdown.dart';
import 'edit_family_member_modal.dart';
import 'create_family_profile_modal.dart';
import 'invite_parent_modal.dart';
import 'merge_family_modal.dart';
import 'invite_teen_modal.dart';
import 'manage_permissions_modal.dart';
import 'profile_settings_modal.dart';
import 'privacy_settings_modal.dart';
import 'security_settings_modal.dart';
import 'delete_account_modal.dart';
import 'edit_member_roles_modal.dart';

class SettingsTabControllerX extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsTabControllerX controller = Get.put(SettingsTabControllerX());
  final List<String> tabs = ["General", "Family", "Account"];
  
  bool _mindfulUsageEnabled = true;
  bool _pushNotificationsEnabled = true;
  double _breakDuration = 5.0;
  double _dailyUsageGoal = 120.0;
  String _selectedInterval = "Every 20 minutes";
  String _selectedTheme = "Light";

  final List<String> _intervals = [
    "Every 10 minutes",
    "Every 20 minutes",
    "Every 30 minutes",
    "Every 45 minutes",
    "Every 60 minutes",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    // Title and Subtitle
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: 'Prompt_Bold',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Customize your family coordination experience",
                      style: TextStyle(
                        fontFamily: 'Prompt_regular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subHeadingColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Tab Navigation
                    _buildTabs(),
                    SizedBox(height: 24.h),
                    // Tab Content
                    Obx(() {
                      if (controller.selectedIndex.value == 0) {
                        return _buildGeneralTab();
                      } else if (controller.selectedIndex.value == 1) {
                        return _buildFamilyTab();
                      } else {
                        return _buildAccountTab();
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMindfulUsageSection(),
          SizedBox(height: 16.h),
          _buildNotificationsSection(),
          SizedBox(height: 16.h),
          _buildAppearanceSection(),
          SizedBox(height: 24.h),
          _buildSaveSettingsButton(),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildFamilyTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFamilyMembersSection(),
          SizedBox(height: 16.h),
          _buildTeenRewardManagementSection(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildAccountTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAccountSettingsSection(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Color(0xFFEDF1F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF757575).withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Obx(() => Row(
          children: List.generate(tabs.length, (index) {
            final bool isSelected = controller.selectedIndex.value == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(index),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Color(0xFFEDF1F7),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : [],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Prompt_regular',
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color:
                          isSelected ? AppColors.textColor : Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        )),
      ),
    );
  }

  Widget _buildMindfulUsageSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
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
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.screen_lock_portrait_outlined,
                  color: AppColors.buttonColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Mindful Usage",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Gentle reminders to take breaks and maintain healthy app usage habits.",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 20.h),
          // Enable toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Enable mindful usage reminders",
                style: TextStyle(
                  fontFamily: 'Prompt_regular',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              Switch(
                value: _mindfulUsageEnabled,
                onChanged: (value) {
                  setState(() {
                    _mindfulUsageEnabled = value;
                  });
                },
                activeColor: AppColors.buttonColor,
                activeTrackColor: AppColors.buttonColor.withOpacity(0.3),
                inactiveThumbColor: Colors.grey[300],
                inactiveTrackColor: Colors.grey[200],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Reminder interval dropdown
          Text(
            "Reminder interval",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 8.h),
          CustomDropdown<String>(
            value: _selectedInterval,
            items: _intervals.toDropdownItems((item) => item),
            onChanged: (String? newValue) {
              setState(() {
                _selectedInterval = newValue!;
              });
            },
          ),
          SizedBox(height: 20.h),
          // Break duration slider
          Text(
            "Suggested break duration: ${_breakDuration.round()} minutes",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 8.h),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.buttonColor,
              inactiveTrackColor: const Color(0xFF757575).withOpacity(0.2),
              thumbColor: AppColors.white,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              overlayColor: AppColors.buttonColor.withOpacity(0.1),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
              trackHeight: 6.h,
            ),
            child: Slider(
              value: _breakDuration,
              min: 1.0,
              max: 30.0,
              divisions: null,
              onChanged: (value) {
                setState(() {
                  _breakDuration = value;
                });
              },
            ),
          ),
          SizedBox(height: 20.h),
          // Daily usage goal slider
          Text(
            "Daily usage goal: ${_dailyUsageGoal.round()} minutes",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 8.h),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.buttonColor,
              inactiveTrackColor: const Color(0xFF757575).withOpacity(0.2),
              thumbColor: AppColors.white,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              overlayColor: AppColors.buttonColor.withOpacity(0.1),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
              trackHeight: 6.h,
            ),
            child: Slider(
              value: _dailyUsageGoal,
              min: 30.0,
              max: 480.0,
              divisions: null,
              onChanged: (value) {
                setState(() {
                  _dailyUsageGoal = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
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
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.buttonColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Notifications",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Manage your notification preferences.",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 20.h),
          // Push notifications toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Push notifications",
                style: TextStyle(
                  fontFamily: 'Prompt_regular',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              Switch(
                value: _pushNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _pushNotificationsEnabled = value;
                  });
                },
                activeColor: AppColors.buttonColor,
                activeTrackColor: AppColors.buttonColor.withOpacity(0.3),
                inactiveThumbColor: Colors.grey[300],
                inactiveTrackColor: Colors.grey[200],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
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
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.palette_outlined,
                  color: AppColors.buttonColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Appearance",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Customize how the app looks and feels",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 20.h),
          // Theme selection cards
          Row(
            children: [
              Expanded(
                child: _buildThemeCard(
                  theme: "Light",
                  previewColor: Colors.white,
                  isSelected: _selectedTheme == "Light",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildThemeCard(
                  theme: "Dark",
                  previewColor: const Color(0xFF1E293B),
                  isSelected: _selectedTheme == "Dark",
                ),
              ),
              // SizedBox(width: 12.w),
              // Expanded(
              //   child: _buildThemeCard(
              //     theme: "Blue Light",
              //     previewColor: Colors.transparent,
              //     gradient: const LinearGradient(
              //       colors: [Color(0xFFFFF8E1), Color(0xFFFFFFFF)],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //     ),
              //     isSelected: _selectedTheme == "Blue Light",
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard({
    required String theme,
    required Color previewColor,
    LinearGradient? gradient,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTheme = theme;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.buttonColor : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60.h,
              decoration: BoxDecoration(
                color: gradient != null ? null : previewColor,
                gradient: gradient,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF757575).withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              theme,
              style: TextStyle(
                fontFamily: 'Prompt_regular',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveSettingsButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement save settings
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          "Save Settings",
          style: TextStyle(
            fontFamily: 'Prompt_regular',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyMembersSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
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
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.people_outline,
                  color: AppColors.buttonColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Family Members",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Manage your family member profiles and permissions",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Current Family Members:",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 12.h),
          // Family Members List
          _buildFamilyMemberCard(
            name: "Emily Walton",
            role: "Mom",
            username: null,
            avatarColor: AppColors.buttonColor,
            avatarLetter: "E",
            isTeen: false,
          ),
          SizedBox(height: 12.h),
          _buildFamilyMemberCard(
            name: "TJ Walton",
            role: "Dad",
            username: null,
            avatarColor: const Color(0xFF3B82F6),
            avatarLetter: "T",
            isTeen: false,
          ),
          SizedBox(height: 12.h),
          _buildFamilyMemberCard(
            name: "Adri Walton",
            role: "Teen",
            username: "@AdriWalton1",
            avatarColor: const Color(0xFF8B5CF6),
            avatarLetter: "A",
            isTeen: true,
          ),
          SizedBox(height: 12.h),
          _buildFamilyMemberCard(
            name: "Evie Walton",
            role: "Child",
            username: null,
            avatarColor: AppColors.buttonColor,
            avatarLetter: "E",
            isTeen: false,
          ),
          SizedBox(height: 20.h),
          // Add New Family Members Cards
          Text(
            "Add New Family Members:",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 12.h),
          // Add Child or Teen Profile Card
          _buildAddOptionCard(
            icon: Icons.person_add_outlined,
            iconColor: const Color(0xFF60A5FA),
            title: "Add Child or Teen Profile",
            description: "Create a coordination profile for children or teens. Perfect for assigning chores, tracking activities, and family planning. No account needed.",
            buttonText: "Add Profile",
            buttonIcon: Icons.add,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const CreateFamilyProfileModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Invite New Parent Card
          _buildAddOptionCard(
            icon: Icons.people_outline,
            iconColor: const Color(0xFF10B981),
            title: "Invite New Parent",
            description: "Send an invitation to a parent who doesn't have an account yet. They'll get an email invitation to create their own account and join your family.",
            buttonText: "Send Invitation",
            buttonIcon: Icons.mail_outline,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const InviteParentModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Connect Existing Parent Account Card
          _buildAddOptionCard(
            icon: Icons.favorite_outline,
            iconColor: const Color(0xFF8B5CF6),
            title: "Connect Existing Parent Account",
            description: "If your partner already has a Mom App account, merge your families together. This combines all your family data into one unified system.",
            buttonText: "Merge Families",
            buttonIcon: Icons.favorite_border,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const MergeFamilyModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Invite Teen with App Access Card
          _buildAddOptionCard(
            icon: Icons.people_outline,
            iconColor: const Color(0xFFFF8C00),
            title: "Invite Teen with App Access",
            description: "Give older teens their own login to view tasks, earn points, and access family information. Includes gamification and parental oversight.",
            buttonText: "Create Teen Account",
            buttonIcon: Icons.people_outline,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const InviteTeenModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Edit Member Roles Button
          _buildSimpleActionButton(
            title: "Edit Member Roles",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const EditMemberRolesModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Manage Permissions Button
          _buildSimpleActionButton(
            title: "Manage Permissions",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ManagePermissionsModal(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyMemberCard({
    required String name,
    required String role,
    String? username,
    required Color avatarColor,
    required String avatarLetter,
    required bool isTeen,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                avatarLetter,
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Prompt_Bold',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  role,
                  style: TextStyle(
                    fontFamily: 'Prompt_regular',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subHeadingColor,
                  ),
                ),
                if (username != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    username,
                    style: TextStyle(
                      fontFamily: 'Prompt_regular',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Action Buttons
          Row(
            children: [
              // Edit Button
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditFamilyMemberModal(
                      memberName: name,
                      currentRole: role,
                      phoneNumber: null, // You can pass actual phone if available
                      email: null, // You can pass actual email if available
                      notificationPreference: "SMS",
                      color: "#EC4899",
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 16.sp,
                    color: AppColors.subHeadingColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // Permissions Button (only for teens)
              if (isTeen) ...[
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to permissions
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.key_outlined,
                      size: 16.sp,
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              // Delete Button
              GestureDetector(
                onTap: () {
                  // TODO: Show delete confirmation
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: 16.sp,
                    color: AppColors.subHeadingColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddOptionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String buttonText,
    required IconData buttonIcon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Prompt_Bold',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    buttonIcon,
                    size: 16.sp,
                    color: AppColors.textColor,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontFamily: 'Prompt_regular',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleActionButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.03),
              offset: const Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
      ),
    );
  }

  Widget _buildTeenRewardManagementSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
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
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.star_outline,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Teen Reward Management",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Manage points and rewards for teen family members",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 20.h),
          // Teen Points Cards
          _buildTeenPointsCard(
            teenName: "Adri Walton",
            points: 1250,
            lastEarned: "2 hours ago",
            tasksCompleted: 8,
            weeklyGoal: 15,
          ),
          SizedBox(height: 12.h),
          _buildTeenPointsCard(
            teenName: "Alex Walton",
            points: 890,
            lastEarned: "1 day ago",
            tasksCompleted: 5,
            weeklyGoal: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildTeenPointsCard({
    required String teenName,
    required int points,
    required String lastEarned,
    required int tasksCompleted,
    required int weeklyGoal,
  }) {
    double progressPercentage = (tasksCompleted / weeklyGoal).clamp(0.0, 1.0);
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.star,
                  color: AppColors.primary,
                  size: 14.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "$teenName - Point Management",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Points Display
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.stars,
                      color: AppColors.primary,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "$points points",
                      style: TextStyle(
                        fontFamily: 'Prompt_Bold',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "Last earned: $lastEarned",
                  style: TextStyle(
                    fontFamily: 'Prompt_regular',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subHeadingColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Weekly Progress
          Row(
            children: [
              Text(
                "Weekly Progress:",
                style: TextStyle(
                  fontFamily: 'Prompt_regular',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "$tasksCompleted/$weeklyGoal tasks",
                style: TextStyle(
                  fontFamily: 'Prompt_regular',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          // Progress Bar
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: const Color(0xFF757575).withOpacity(0.2),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progressPercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
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
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Account Settings",
                style: TextStyle(
                  fontFamily: 'Prompt_Bold',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Manage your account preferences and privacy",
            style: TextStyle(
              fontFamily: 'Prompt_regular',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 20.h),
          // Profile Settings Button
          _buildAccountButton(
            title: "Profile Settings",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ProfileSettingsModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Privacy Settings Button
          _buildAccountButton(
            title: "Privacy Settings",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const PrivacySettingsModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Security Settings Button
          _buildAccountButton(
            title: "Security Settings",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const SecuritySettingsModal(),
              );
            },
          ),
          SizedBox(height: 12.h),
          // Delete Account Button
          _buildAccountButton(
            title: "Delete Account",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const DeleteAccountModal(),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildAccountButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF757575).withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.03),
              offset: const Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Prompt_Bold',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ),
    );
  }
}
