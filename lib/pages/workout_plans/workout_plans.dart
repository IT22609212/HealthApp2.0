class Exercise {
  final String name;
  final String image;
  final int sets;
  final int reps;
  final int time; // Time in minutes
  final SwapExercise swapExercise;

  Exercise({
    required this.name,
    required this.image,
    required this.sets,
    required this.reps,
    required this.time,
    required this.swapExercise,
  });
}

class SwapExercise {
  final String name;
  final int reps;
  final int sets;
  final String image;
  final String advantage;
  final String disadvantage;
  final int effectivenessChange;

  SwapExercise({
    required this.name,
    required this.reps,
    required this.sets,
    required this.image,
    required this.advantage,
    required this.disadvantage,
    required this.effectivenessChange,
  });
}

// Plan data for each category and plan number
final Map<String, Map<int, Map<String, dynamic>>> planData = {
  'Average': {
    1: {
      'time': 60, // Total time in minutes
      'effectiveness': 90, // Effectiveness percentage
      'exercises': [
        Exercise(
          name: 'Front Squat',
          image: 'assets/images/front_squat.gif',
          sets: 3,
          reps: 15,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Bodyweight Squat',
            reps: 20,
            sets: 3,
            image: 'assets/images/body_weight_squat.gif',
            advantage: 'No equipment required.',
            disadvantage: 'Lower resistance compared to weights.',
            effectivenessChange: -3,
          ),
        ),
        Exercise(
          name: 'Hip Abduction',
          image: 'assets/images/hip_abduction.png',
          sets: 4,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Side Lying Leg Raise',
            reps: 15,
            sets: 3,
            image: 'assets/images/side_lying_leg_raise.gif',
            advantage: 'Can be done anywhere.',
            disadvantage: 'Less range of motion.',
            effectivenessChange: -2,
          ),
        ),
        Exercise(
          name: 'Glute Kickbacks',
          image: 'assets/images/glute_kickbacks.gif',
          sets: 3,
          reps: 5,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Donkey Kicks',
            reps: 10,
            sets: 3,
            image: 'assets/images/donkey_kickbacks.gif',
            advantage: 'Targets glutes effectively without weights.',
            disadvantage: 'Less resistance than glute kickbacks.',
            effectivenessChange: -2,
          ),
        ),
        Exercise(
          name: 'Push Up',
          image: 'assets/images/push_ups.gif',
          sets: 4,
          reps: 12,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Incline Push Up',
            reps: 10,
            sets: 3,
            image: 'assets/images/incline_pushups.png',
            advantage: 'Puts less strain on the wrists.',
            disadvantage: 'Less intensity compared to regular push-up.',
            effectivenessChange: -2,
          ),
        ),
        Exercise(
          name: 'Plank',
          image: 'assets/images/plank.gif',
          sets: 2,
          reps: 60, // 60 seconds
          time: 5,
          swapExercise: SwapExercise(
            name: 'Knee Plank',
            reps: 30, // 30 seconds
            sets: 3,
            image: 'assets/images/knee_plank.png',
            advantage: 'Easier on the back and shoulders.',
            disadvantage: 'Less core activation than a full plank.',
            effectivenessChange: -1, // Decrease effectiveness by 1%
          ),
        ),
        Exercise(
          name: 'Jump Rope',
          image: 'assets/images/jump_rope.gif',
          sets: 3,
          reps: 50, // Number of jumps
          time: 5,
          swapExercise: SwapExercise(
            name: 'High Knees',
            reps: 30, // 30 seconds
            sets: 3,
            image: 'assets/images/high_knees.gif',
            advantage: 'Improves coordination and increases heart rate.',
            disadvantage:
                'Requires more space and can be challenging for beginners.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),
      ],
    },
    2: {
      'time': 60,
      'effectiveness': 80,
      'exercises': [
        // Bench Press Exercise
        Exercise(
          name: 'Bench Press',
          image: 'assets/images/bench_press.gif',
          sets: 4,
          reps: 12,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Dumbbell Press',
            reps: 12,
            sets: 4,
            image: 'assets/images/dumbell_press.gif',
            advantage: 'Allows for a greater range of motion.',
            disadvantage:
                'Requires more stabilization, which can be challenging for beginners.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Pull Up Exercise
        Exercise(
          name: 'Pull Up',
          image: 'assets/images/pull_up.gif',
          sets: 3,
          reps: 8,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Assisted Pull Up',
            reps: 8,
            sets: 3,
            image: 'assets/images/assisted_pull_up.gif',
            advantage: 'Easier on the muscles and helps build strength.',
            disadvantage: 'Less intensity than a standard pull-up.',
            effectivenessChange: -2, // Decrease effectiveness by 2%
          ),
        ),

// Deadlift Exercise
        Exercise(
          name: 'Deadlift',
          image: 'assets/images/dead_lift.gif',
          sets: 4,
          reps: 10,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Romanian Deadlift',
            reps: 10,
            sets: 4,
            image: 'assets/images/romanian_deadlift.png',
            advantage: 'Focuses more on hamstrings and glutes.',
            disadvantage:
                'Less total body engagement than a standard deadlift.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Lateral Raise Exercise
        Exercise(
          name: 'Lateral Raise',
          image: 'assets/images/lateral_raise.gif',
          sets: 3,
          reps: 10,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Front Raise',
            reps: 10,
            sets: 3,
            image: 'assets/images/front_raise.gif',
            advantage: 'Targets the front deltoids more directly.',
            disadvantage: 'Does not engage the lateral deltoids as much.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Bicep Curl Exercise
        Exercise(
          name: 'Bicep Curl',
          image: 'assets/images/bicep_curl.gif',
          sets: 4,
          reps: 12,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Hammer Curl',
            reps: 12,
            sets: 4,
            image: 'assets/images/hammer_curl.gif',
            advantage: 'Targets both the biceps and brachialis muscles.',
            disadvantage:
                'Can be easier on the wrist for some but less focused on the biceps.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Tricep Dip Exercise
        Exercise(
          name: 'Tricep Dip',
          image: 'assets/images/tricep_dip.gif',
          sets: 4,
          reps: 10,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Close Grip Bench Press',
            reps: 10,
            sets: 4,
            image: 'assets/images/close_grip_bench_press.gif',
            advantage:
                'Great for targeting the triceps and chest simultaneously.',
            disadvantage:
                'Can be challenging for those with wrist or shoulder issues.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),
      ],
    },
    3: {
      'time': 70,
      'effectiveness': 95,
      'exercises': [
        // Overhead Press Exercise
        Exercise(
          name: 'Overhead Press',
          image: 'assets/images/overhead_press.gif',
          sets: 3,
          reps: 12,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Arnold Press',
            reps: 12,
            sets: 3,
            image: 'assets/images/arnold_press.gif',
            advantage: 'Engages more muscle fibers due to rotation.',
            disadvantage: 'May be difficult for those with shoulder issues.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Lunges Exercise
        Exercise(
          name: 'Lunges',
          image: 'assets/images/lunges.gif',
          sets: 3,
          reps: 10,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Step Ups',
            reps: 10,
            sets: 3,
            image: 'assets/images/step_ups.gif',
            advantage:
                'Targets the same muscle groups with less strain on the knees.',
            disadvantage: 'Requires a stable surface to perform safely.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Lat Pulldown Exercise
        Exercise(
          name: 'Lat Pulldown',
          image: 'assets/images/lat_pulldown.gif',
          sets: 4,
          reps: 12,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Chin Up',
            reps: 12,
            sets: 4,
            image: 'assets/images/chin_up.gif',
            advantage: 'Engages the biceps along with the back muscles.',
            disadvantage: 'More challenging for beginners than lat pulldowns.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Bent Over Row Exercise
        Exercise(
          name: 'Bent Over Row',
          image: 'assets/images/bent_over_row.gif',
          sets: 3,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Seated Row',
            reps: 10,
            sets: 3,
            image: 'assets/images/seated_row.png',
            advantage: 'Helps maintain proper posture and reduces back strain.',
            disadvantage:
                'Less engagement of stabilizing muscles compared to bent over row.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Crunches Exercise
        Exercise(
          name: 'Crunches',
          image: 'assets/images/crunches.gif',
          sets: 4,
          reps: 20,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Plank',
            reps: 60, // Time in seconds
            sets: 4,
            image: 'assets/images/plank.gif',
            advantage: 'Engages multiple core muscles and improves stability.',
            disadvantage: 'May be too difficult for beginners.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Leg Press Exercise
        Exercise(
          name: 'Leg Press',
          image: 'assets/images/leg_press.gif',
          sets: 3,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Squats',
            reps: 10,
            sets: 3,
            image: 'assets/images/squat.gif',
            advantage: 'Engages more muscle groups and improves balance.',
            disadvantage: 'Requires good form to prevent injury.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),
      ],
    },
  },
  'Underweight': {
    1: {
      'time': 45, // Shorter duration focused on strength
      'effectiveness': 85,
      'exercises': [
        // Push Up Exercise
        Exercise(
          name: 'Push Up',
          image: 'assets/images/push_ups.gif',
          sets: 4,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Incline Push Up',
            reps: 10,
            sets: 4,
            image: 'assets/images/incline_pushups.png',
            advantage:
                'Easier on the shoulders and helps build strength gradually.',
            disadvantage:
                'May not engage the chest muscles as intensely as standard push-ups.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Bench Press Exercise
        Exercise(
          name: 'Bench Press',
          image: 'assets/images/bench_press.gif',
          sets: 4,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Dumbbell Bench Press',
            reps: 10,
            sets: 4,
            image: 'assets/images/dumbbell_bench_press.gif',
            advantage:
                'Allows for a greater range of motion and engages stabilizing muscles.',
            disadvantage:
                'May require more coordination than barbell bench press.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Squat Exercise
        Exercise(
          name: 'Squat',
          image: 'assets/images/squat.gif',
          sets: 3,
          reps: 10,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Goblet Squat',
            reps: 10,
            sets: 3,
            image: 'assets/images/goblet_squat.gif',
            advantage: 'Improves form and engages the core more effectively.',
            disadvantage:
                'May be challenging for those with wrist or shoulder mobility issues.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Crunches Exercise
        Exercise(
          name: 'Crunches',
          image: 'assets/images/crunches.gif',
          sets: 3,
          reps: 15,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Reverse Crunch',
            reps: 15,
            sets: 3,
            image: 'assets/images/reverse_crunches.gif',
            advantage: 'Targets the lower abs more effectively.',
            disadvantage:
                'May be difficult for beginners or those with back issues.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Bicep Curl Exercise
        Exercise(
          name: 'Bicep Curl',
          image: 'assets/images/bicep_curl.gif',
          sets: 3,
          reps: 8,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Hammer Curl',
            reps: 8,
            sets: 3,
            image: 'assets/images/hammer_curl.gif',
            advantage:
                'Engages both the biceps and forearms for balanced strength.',
            disadvantage:
                'May feel awkward for beginners who are used to traditional curls.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),
      ],
    },
    2: {
      'time': 55,
      'effectiveness': 90,
      'exercises': [
        // Deadlift Exercise
        Exercise(
          name: 'Deadlift',
          image: 'assets/images/dead_lift.gif',
          sets: 3,
          reps: 8,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Sumo Deadlift',
            reps: 8,
            sets: 3,
            image: 'assets/images/sumo_deadlift.gif',
            advantage: 'Targets inner thighs and glutes more effectively.',
            disadvantage:
                'May feel uncomfortable for those with hip mobility issues.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Overhead Press Exercise
        Exercise(
          name: 'Overhead Press',
          image: 'assets/images/overhead_press.gif',
          sets: 3,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Dumbbell Shoulder Press',
            reps: 10,
            sets: 3,
            image: 'assets/images/dumbell_press.gif',
            advantage:
                'Allows for more natural movement and engages stabilizing muscles.',
            disadvantage: 'Requires good shoulder stability and strength.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Lunges Exercise
        Exercise(
          name: 'Lunges',
          image: 'assets/images/lunges.gif',
          sets: 3,
          reps: 12,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Reverse Lunges',
            reps: 12,
            sets: 3,
            image: 'assets/images/reverse_lunges.gif',
            advantage: 'Easier on the knees and helps with balance.',
            disadvantage: 'May not feel as intense as forward lunges.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Push Up Exercise
        Exercise(
          name: 'Push Up',
          image: 'assets/images/push_ups.gif',
          sets: 3,
          reps: 10,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Knee Push Up',
            reps: 10,
            sets: 3,
            image: 'assets/images/knee_push_up.gif',
            advantage: 'Great for beginners or those with wrist issues.',
            disadvantage:
                'Easier than standard push-ups and may not engage chest muscles as effectively.',
            effectivenessChange: -1, // Decrease effectiveness by 1%
          ),
        ),

// Pull Up Exercise
        Exercise(
          name: 'Pull Up',
          image: 'assets/images/pull_up.gif',
          sets: 2,
          reps: 6,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Assisted Pull Up',
            reps: 6,
            sets: 2,
            image: 'assets/images/assisted_pull_up.gif',
            advantage: 'Great for building strength without overstraining.',
            disadvantage:
                'Might not engage the back muscles as much as traditional pull-ups.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),
      ],
    },
    3: {
      'time': 70,
      'effectiveness': 95,
      'exercises': [
        // Squat Exercise
        Exercise(
          name: 'Squat',
          image: 'assets/images/squat.gif',
          sets: 4,
          reps: 10,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Goblet Squat',
            reps: 10,
            sets: 4,
            image: 'assets/images/goblet_squat.gif',
            advantage: 'Enhances squat form and engages core muscles.',
            disadvantage:
                'May be challenging for those with limited shoulder mobility.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Deadlift Exercise
        Exercise(
          name: 'Deadlift',
          image: 'assets/images/dead_lift.gif',
          sets: 4,
          reps: 10,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Romanian Deadlift',
            reps: 10,
            sets: 4,
            image: 'assets/images/romanian_deadlift.png',
            advantage: 'Focuses on hamstrings and lower back strength.',
            disadvantage: 'Requires proper form to avoid injury.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Lat Pulldown Exercise
        Exercise(
          name: 'Lat Pulldown',
          image: 'assets/images/lat_pulldown.gif',
          sets: 4,
          reps: 8,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Pull Up',
            reps: 6,
            sets: 4,
            image: 'assets/images/pull_up.gif',
            advantage:
                'Engages more muscle groups and builds upper body strength.',
            disadvantage: 'Requires more strength compared to lat pulldown.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Dumbbell Bench Press Exercise
        Exercise(
          name: 'Dumbbell Bench Press',
          image: 'assets/images/dumbbell_bench_press.gif',
          sets: 4,
          reps: 12,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Barbell Bench Press',
            reps: 12,
            sets: 4,
            image: 'assets/images/barbell_bench_press.gif',
            advantage:
                'Allows for heavier lifting and increased muscle engagement.',
            disadvantage: 'Requires a spotter for safety with heavier weights.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Tricep Dip Exercise
        Exercise(
          name: 'Tricep Dip',
          image: 'assets/images/tricep_dip.gif',
          sets: 3,
          reps: 8,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Bench Dip',
            reps: 8,
            sets: 3,
            image: 'assets/images/bench_dips.gif',
            advantage: 'Easier on the shoulders and great for beginners.',
            disadvantage:
                'May not engage triceps as effectively as tricep dips.',
            effectivenessChange: -1, // Decrease effectiveness by 1%
          ),
        ),
      ],
    },
  },
  'Overweight': {
    1: {
      'time': 45, // Cardio-focused for calorie burn
      'effectiveness': 75,
      'exercises': [
        // Jump Rope Exercise
        Exercise(
          name: 'Jump Rope',
          image: 'assets/images/jump_rope.gif',
          sets: 5,
          reps: 100,
          time: 10,
          swapExercise: SwapExercise(
            name: 'High Knees',
            reps: 50,
            sets: 4,
            image: 'assets/images/high_knees.gif',
            advantage: 'Improves agility and cardio fitness.',
            disadvantage: 'Can be tough on the knees if done improperly.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Mountain Climbers Exercise
        Exercise(
          name: 'Mountain Climbers',
          image: 'assets/images/mountain_climbers.gif',
          sets: 4,
          reps: 50,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Burpees',
            reps: 20,
            sets: 3,
            image: 'assets/images/burpees.gif',
            advantage: 'Full-body workout that increases heart rate quickly.',
            disadvantage:
                'Requires a higher fitness level to perform effectively.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// High Knees Exercise
        Exercise(
          name: 'High Knees',
          image: 'assets/images/high_knees.gif',
          sets: 4,
          reps: 50,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Butt Kickers',
            reps: 50,
            sets: 4,
            image: 'assets/images/butt_kickers.gif',
            advantage:
                'Focuses on hamstrings and improves cardiovascular fitness.',
            disadvantage:
                'May not engage the core as effectively as high knees.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Burpees Exercise
        Exercise(
          name: 'Burpees',
          image: 'assets/images/burpees.gif',
          sets: 3,
          reps: 20,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Jumping Jacks',
            reps: 50,
            sets: 3,
            image: 'assets/images/jumping_jacks.gif',
            advantage: 'Great for warm-up and full-body cardio.',
            disadvantage: 'Lower intensity compared to burpees.',
            effectivenessChange: -1, // Decrease effectiveness by 1%
          ),
        ),

// Plank Exercise
        Exercise(
          name: 'Plank',
          image: 'assets/images/plank.gif',
          sets: 2,
          reps: 60,
          time: 5,
          swapExercise: SwapExercise(
            name: 'Side Plank',
            reps: 30,
            sets: 2,
            image: 'assets/images/side_plank.gif',
            advantage: 'Targets obliques and improves stability.',
            disadvantage: 'May be challenging for beginners.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),
      ],
    },
    2: {
      'time': 60,
      'effectiveness': 85,
      'exercises': [
        // Treadmill Run Exercise
        Exercise(
          name: 'Treadmill Run',
          image: 'assets/images/treadmill.gif',
          sets: 1,
          reps: 0,
          time: 20,
          swapExercise: SwapExercise(
            name: 'Outdoor Run',
            reps: 0,
            sets: 1,
            image: 'assets/images/outdoor_run.gif',
            advantage: 'Engages more muscle groups and offers varied terrain.',
            disadvantage:
                'Weather dependent and may not be as controlled as a treadmill.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Jumping Jacks Exercise
        Exercise(
          name: 'Jumping Jacks',
          image: 'assets/images/jumping_jacks.gif',
          sets: 4,
          reps: 50,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Star Jumps',
            reps: 20,
            sets: 3,
            image: 'assets/images/star_jump.jpg',
            advantage:
                'Increases heart rate and adds a fun twist to regular jumping jacks.',
            disadvantage:
                'Higher impact, which may be difficult for beginners.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Bicycle Crunches Exercise
        Exercise(
          name: 'Bicycle Crunches',
          image: 'assets/images/bicycle_crunches.gif',
          sets: 3,
          reps: 15,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Plank with Knee Tucks',
            reps: 15,
            sets: 3,
            image: 'assets/images/plank_with_knee_tucks.gif',
            advantage:
                'Works the core while also improving shoulder stability.',
            disadvantage: 'Requires good core strength and stability.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Russian Twists Exercise
        Exercise(
          name: 'Russian Twists',
          image: 'assets/images/russian_twist.gif',
          sets: 3,
          reps: 20,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Medicine Ball Twists',
            reps: 15,
            sets: 3,
            image: 'assets/images/medicine_ball_twist.gif',
            advantage:
                'Engages more muscles with added weight for core strength.',
            disadvantage: 'May require access to a medicine ball.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Squat Jumps Exercise
        Exercise(
          name: 'Squat Jumps',
          image: 'assets/images/squat_jumps.gif',
          sets: 3,
          reps: 15,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Box Jumps',
            reps: 10,
            sets: 3,
            image: 'assets/images/box_jumps.gif',
            advantage: 'Builds explosive strength and power in the legs.',
            disadvantage:
                'Requires a sturdy platform and may pose a risk of injury if done incorrectly.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),
      ],
    },
    3: {
      'time': 70,
      'effectiveness': 95,
      'exercises': [
        // Elliptical Exercise
        Exercise(
          name: 'Elliptical',
          image: 'assets/images/elliptical.gif',
          sets: 1,
          reps: 0,
          time: 25,
          swapExercise: SwapExercise(
            name: 'Outdoor Cycling',
            reps: 0,
            sets: 1,
            image: 'assets/images/outdoor_cycling.gif',
            advantage:
                'Provides a full-body workout while being easy on the joints.',
            disadvantage:
                'Weather dependent and may require more setup than an elliptical machine.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Rowing Machine Exercise
        Exercise(
          name: 'Rowing Machine',
          image: 'assets/images/rowing_machine.gif',
          sets: 1,
          reps: 0,
          time: 15,
          swapExercise: SwapExercise(
            name: 'Kayaking',
            reps: 0,
            sets: 1,
            image: 'assets/images/kayaking.gif',
            advantage:
                'Works the upper body and core while also being a great cardio workout.',
            disadvantage:
                'Requires access to water and can be weather dependent.',
            effectivenessChange: 1, // Increase effectiveness by 1%
          ),
        ),

// Box Jumps Exercise
        Exercise(
          name: 'Box Jumps',
          image: 'assets/images/box_jumps.gif',
          sets: 3,
          reps: 12,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Step Ups',
            reps: 12,
            sets: 3,
            image: 'assets/images/step_ups.gif',
            advantage:
                'Easier on the joints while still building lower body strength.',
            disadvantage:
                'Requires a stable surface and may not provide as much explosiveness as box jumps.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Flutter Kicks Exercise
        Exercise(
          name: 'Flutter Kicks',
          image: 'assets/images/flutter_kicks.GIF',
          sets: 4,
          reps: 20,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Leg Raises',
            reps: 15,
            sets: 4,
            image: 'assets/images/leg_raises.gif',
            advantage: 'Targets the lower abs effectively.',
            disadvantage: 'Requires good lower back stability.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),

// Lateral Shuffles Exercise
        Exercise(
          name: 'Lateral Shuffles',
          image: 'assets/images/lateral_shuffles.gif',
          sets: 3,
          reps: 15,
          time: 10,
          swapExercise: SwapExercise(
            name: 'Side Lunges',
            reps: 12,
            sets: 3,
            image: 'assets/images/side_lunges.gif',
            advantage:
                'Increases flexibility and strength in the inner thighs.',
            disadvantage: 'May require good balance and mobility.',
            effectivenessChange: 0, // Effectiveness remains the same
          ),
        ),
      ],
    },
  },
};
