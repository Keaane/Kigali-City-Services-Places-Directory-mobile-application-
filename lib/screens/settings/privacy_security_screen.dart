import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _emailNotifications = true;
  bool _locationTracking = true;
  bool _dataSharing = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        title: Text(
          'Privacy & Security',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Privacy Settings
            _sectionHeader('Privacy Settings'),
            _settingTile(
              icon: Icons.notifications_outlined,
              title: 'Email Notifications',
              subtitle: 'Receive updates about your listings and alerts',
              trailing: Switch(
                value: _emailNotifications,
                onChanged: (value) => setState(() => _emailNotifications = value),
                activeThumbColor: AppColors.primary,
              ),
            ),
            _settingTile(
              icon: Icons.location_on_outlined,
              title: 'Location Tracking',
              subtitle: 'Allow app to access your location for better service',
              trailing: Switch(
                value: _locationTracking,
                onChanged: (value) => setState(() => _locationTracking = value),
                activeThumbColor: AppColors.primary,
              ),
            ),
            _settingTile(
              icon: Icons.share_outlined,
              title: 'Data Sharing',
              subtitle: 'Share anonymous usage data to improve the app',
              trailing: Switch(
                value: _dataSharing,
                onChanged: (value) => setState(() => _dataSharing = value),
                activeThumbColor: AppColors.primary,
              ),
            ),

            const SizedBox(height: 24),

            // Security Settings
            _sectionHeader('Security Settings'),
            _settingTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your account password',
              trailing: const Icon(Icons.chevron_right, color: AppColors.mutedForeground),
              onTap: () => _showChangePasswordDialog(context),
            ),
            _settingTile(
              icon: Icons.security_outlined,
              title: 'Two-Factor Authentication',
              subtitle: 'Add an extra layer of security',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Coming Soon',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.warning,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Account Actions
            _sectionHeader('Account Actions'),
            _settingTile(
              icon: Icons.download_outlined,
              title: 'Download My Data',
              subtitle: 'Export all your personal data and listings',
              trailing: const Icon(Icons.chevron_right, color: AppColors.mutedForeground),
              onTap: () => _showDownloadDataDialog(context),
            ),
            _settingTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              subtitle: 'Permanently delete your account and all data',
              trailing: const Icon(Icons.chevron_right, color: AppColors.mutedForeground),
              onTap: () => _showDeleteAccountDialog(context),
              isDestructive: true,
            ),

            const SizedBox(height: 24),

            // Privacy Policy & Terms
            _sectionHeader('Legal'),
            _settingTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy and data handling practices',
              trailing: const Icon(Icons.open_in_new, color: AppColors.mutedForeground),
              onTap: () => _showPrivacyPolicy(context),
            ),
            _settingTile(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              subtitle: 'Review our terms and conditions',
              trailing: const Icon(Icons.open_in_new, color: AppColors.mutedForeground),
              onTap: () => _showTermsOfService(context),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.05 * 13,
          color: AppColors.mutedForeground,
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? AppColors.destructive : AppColors.foreground,
          size: 24,
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDestructive ? AppColors.destructive : AppColors.foreground,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.mutedForeground,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Change Password',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (newPasswordController.text != confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: AppColors.destructive,
                          ),
                        );
                        return;
                      }

                      if (newPasswordController.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password must be at least 6 characters'),
                            backgroundColor: AppColors.destructive,
                          ),
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      try {
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        final success = await authProvider.updatePassword(
                          currentPasswordController.text,
                          newPasswordController.text,
                        );

                        if (success && mounted) {
                          Navigator.pop(dialogContext);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password updated successfully'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        } else if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(authProvider.errorMessage ?? 'Failed to update password'),
                              backgroundColor: AppColors.destructive,
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('An error occurred. Please try again.'),
                              backgroundColor: AppColors.destructive,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) setState(() => isLoading = false);
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDownloadDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Download Your Data',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'We\'ll prepare a file containing all your personal information and listings. This may take a few minutes. You\'ll receive an email when it\'s ready.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data export request submitted. Check your email soon.'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Request Export'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Account',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: AppColors.destructive,
          ),
        ),
        content: Text(
          'This action cannot be undone. All your listings, profile information, and account data will be permanently deleted. Are you sure you want to continue?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmAccountDeletion(context);
            },
            child: Text(
              'Delete Account',
              style: TextStyle(color: AppColors.destructive),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmAccountDeletion(BuildContext context) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Confirm Account Deletion',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please enter your password to confirm account deletion.',
              style: GoogleFonts.inter(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter your password'),
                    backgroundColor: AppColors.destructive,
                  ),
                );
                return;
              }

              Navigator.pop(context);

              try {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                final success = await authProvider.deleteAccount(passwordController.text);

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account deleted successfully'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                } else if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(authProvider.errorMessage ?? 'Failed to delete account'),
                      backgroundColor: AppColors.destructive,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('An error occurred. Please try again.'),
                      backgroundColor: AppColors.destructive,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Delete Forever',
              style: TextStyle(color: AppColors.destructive),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        content: SingleChildScrollView(
          child: Text(
            'We respect your privacy and are committed to protecting your personal data. This app collects minimal information necessary to provide our services.\n\n'
            'Data we collect:\n'
            '• Account information (name, email)\n'
            '• Service listings you create\n'
            '• Location data (when using map features)\n\n'
            'We do not sell your data to third parties. Your information is used only to provide and improve our services.',
            style: GoogleFonts.inter(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Terms of Service',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        content: SingleChildScrollView(
          child: Text(
            'By using Kigali Services, you agree to:\n\n'
            '• Provide accurate information when creating listings\n'
            '• Respect other users and the community\n'
            '• Not misuse the platform for illegal activities\n'
            '• Keep your account information secure\n\n'
            'We reserve the right to suspend accounts that violate these terms.',
            style: GoogleFonts.inter(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}