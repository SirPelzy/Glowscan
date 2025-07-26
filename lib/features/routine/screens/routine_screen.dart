import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';

// Placeholder model for a routine step
class RoutineStep {
  final String title;
  final String productName;
  final String productImageUrl;
  bool isCompleted;

  RoutineStep({
    required this.title,
    required this.productName,
    required this.productImageUrl,
    this.isCompleted = false,
  });
}

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  // State for the Morning/Night toggle
  bool _isMorning = true;

  // Mock data - this would be fetched from your backend via a Riverpod provider
  final List<RoutineStep> _morningRoutine = [
    RoutineStep(title: 'Step 1: Cleanser', productName: 'Gentle Foaming Cleanser', productImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB_MU1-OMT-BG5_QdVTaMhjalLOzUfq148IsmsjanwiC_QW7LCw3h5Vtr0cmw7_DFy3SO7Ik7LgkX2AH-UhXxAg7neJcTjgbmKboB-nQZ6iEaUsFpCitDPK3Gg2ZKweVJjvxL0AoxNKLXyAYf9pdyvh3UVkpTmv5dt5PEkCMUD9aYZE9zrGB1-WqA9Y6tDe3y9uBl_GUTeUujthNG6828zqxL4ZekzQ5RuA26Thx__yT4Qg4Sl7o1DecgNChRnA731EfOEtPQS42blG'),
    RoutineStep(title: 'Step 2: Serum', productName: 'Vitamin C Serum', productImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsdTULsK5I9AcOT5Z7Sd9jyA8JSJo6Y1SMvjZbOlMrL3vYW8N-_iji9sbi46C7DiVFPE0L44H-p6ANEOVb-p4E9gTPf96uAjC_gMGfrEC3BpQtO1GuyW9NvkWOdiuEOTYqOp0_BJF7a41pYdV13IEPMsnWNRiBbd0uns-XqwgrMZMiPuhYhwgmAkIIKp8rRQGNofiGON6-qCZJperP9ml1otR6FvZhdQZb-D4vPLRaM8DMh7meNRV04zY8sTMSCL-9DYd1wlhn18AO'),
    RoutineStep(title: 'Step 3: Moisturizer', productName: 'Hydrating Daily Moisturizer', productImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC2yYe7Ay9UuEwvpqnDNyYwylSXTCqgLOkVHBZQNQFzYiHM4Id4TLJLr6bgHt4hCpMRV0oKf2sLijinmqiQwpEF7vmcpnEUPtcCfuWhjX5rIqQ6RmaISqGebAppLLrJnPB5ndKqzvgieKQiUgDevUpmVY5oRkW_oaCPWQAVuasBkMqB1uoSO5uX-G_cKFMHZpuWDD0C5Odcit2oDQuh0Dt82oKf9BFLT6Q_QsVElqHqVevtw4txfRX1tKeoVPEz0llaI3JkLHKomL93'),
    RoutineStep(title: 'Step 4: Sunscreen', productName: 'Broad Spectrum SPF 30', productImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBbb4cIcS3vVoNpGU0g6OFdCjLdGGaCb1HZ1cEAeRJ5kBlZHqkRT0Lq5c875uk20dbJXgIOg8bPJJ6Ntig7xo9aojAw_ZYEZyIHWFJ6o29U-fcv-JIWtpMqlt_qNL58UO59Nt6X9VBlcD7QE189aV_pr8_DD-ihe5s4Cjt85dzbrxAjEqdhbtQ6Z-F9V14pEl7PdU_IhurWWF0Hs1cXjlBTrsSj-plDMu4W716sKqeyXxTVcc5EDczRawHp6xhnUTdoqAyYT6gjejfC'),
  ];
  
  // TODO: Add a _nightRoutine list

  @override
  Widget build(BuildContext context) {
    // Determine which routine list to show
    final currentRoutine = _isMorning ? _morningRoutine : []; // Replace [] with _nightRoutine

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/x-close.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Routine', style: AppTheme.heading2),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSegmentedControl(),
            ListView.builder(
              itemCount: currentRoutine.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _RoutineStepCard(
                  step: currentRoutine[index],
                  onChanged: (value) {
                    setState(() {
                      currentRoutine[index].isCompleted = value ?? false;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Expanded(
              child: _SegmentedControlButton(
                text: 'Morning',
                isSelected: _isMorning,
                onTap: () => setState(() => _isMorning = true),
              ),
            ),
            Expanded(
              child: _SegmentedControlButton(
                text: 'Night',
                isSelected: !_isMorning,
                onTap: () => setState(() => _isMorning = false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedControlButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentedControlButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? AppTheme.textPrimary : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}


class _RoutineStepCard extends StatelessWidget {
  final RoutineStep step;
  final ValueChanged<bool?> onChanged;

  const _RoutineStepCard({required this.step, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(step.title, style: AppTheme.bodyText.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(step.productImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Recommendation', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.w500)),
                  Text(step.productName, style: AppTheme.subtitle.copyWith(fontSize: 14)),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Complete', style: AppTheme.bodyText),
              Checkbox(
                value: step.isCompleted,
                onChanged: onChanged,
                activeColor: const Color(0xFFEEBDCE),
                side: const BorderSide(color: AppTheme.border, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
