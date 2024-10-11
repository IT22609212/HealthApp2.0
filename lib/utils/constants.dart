import '../models/activity.dart'; // Import the Activity model

final Map<String, List<Activity>> moodActivities = {
  'Happy': [
    Activity(
      title: 'Creative Writing',
      description: 'Express your thoughts creatively by writing a story or a poem. Creative writing allows you to escape into your imagination and explore new ideas. It helps improve your mood by channeling your positive energy into something productive. Writing creatively also boosts your cognitive abilities and allows you to reflect on your emotions in a healthy way.',
      imagePath: 'assets/images/writting.jpg',
      time: '30 mins',
    ),
    Activity(
      title: 'Dancing',
      description: 'Dance to your favorite music and release your energy in a fun way. Dancing releases endorphins, which improve your mood and make you feel happier. It is a great way to exercise without feeling like you are working out. Letting go and moving to the beat of your favorite songs can be incredibly freeing and empowering. You can dance alone or invite friends for a dance party.',
      imagePath: 'assets/images/dancing1.jpg',
      time: '20 mins',
    ),
    Activity(
      title: 'Playing Instrument',
      description: 'Play some tunes on your favorite instrument, such as a guitar, piano, or any other instrument you like. Playing music not only serves as an outlet for your emotions, but it also improves focus and concentration. Learning new songs or creating your own music can be deeply satisfying and fulfilling. Music can connect you to happy memories and help you release any stress or worries you may have.',
      imagePath: 'assets/images/playing.jpg',
      time: '45 mins',
    ),
    Activity(
      title: 'Gardening',
      description: 'Spend some time in the garden tending to plants, flowers, or herbs. Gardening is an excellent way to connect with nature and cultivate a sense of calm. Being surrounded by greenery and fresh air has positive effects on mental health and well-being. The physical activity involved in gardening helps release endorphins, promoting a sense of happiness. Watching plants grow and bloom can be very rewarding.',
      imagePath: 'assets/images/gardening.jpg',
      time: '60 mins',
    ),
    Activity(
      title: 'Cooking a New Recipe',
      description: 'Try cooking a new recipe you have always wanted to make. Cooking is a creative and therapeutic activity that engages all your senses. Experimenting with new ingredients and techniques gives you a sense of accomplishment and satisfaction. Sharing the delicious dish you create with family or friends can also foster positive connections and make you feel happy. Don’t be afraid to add your own twist to the recipe!',
      imagePath: 'assets/images/cooking.jpg',
      time: '50 mins',
    ),
  ],
  'Sad': [
    Activity(
      title: 'Meditation',
      description: 'Focus on your breathing to calm your mind and let go of negative emotions. Meditation helps center your thoughts and brings you to the present moment. It is a powerful practice to release stress and achieve inner peace. By practicing deep breathing and mindfulness, you can redirect your thoughts away from sadness. Even a few minutes of meditation can make a big difference in how you feel.',
      imagePath: 'assets/images/meditation.jpg',
      time: '15 mins',
    ),
    Activity(
      title: 'Journaling',
      description: 'Write down your feelings to process your emotions in a healthy way. Journaling is an effective way to express yourself without any judgments. It allows you to acknowledge your thoughts, vent frustrations, and gain perspective. Writing about your emotions helps you better understand them and lets you identify patterns over time. Use your journal as a safe space to reflect on what you are going through.',
      imagePath: 'assets/images/journaling.jpg',
      time: '20 mins',
    ),
    Activity(
      title: 'Call a Friend',
      description: 'Reach out to someone you trust for support and a listening ear. Talking about your emotions with a close friend or family member can help you feel less alone. Social support is essential for emotional well-being, and sharing your feelings may provide you with comfort and understanding. Remember that your loved ones are there for you and want to support you when you are feeling down.',
      imagePath: 'assets/images/call.jpg',
      time: '30 mins',
    ),
    Activity(
      title: 'Watch a Comedy Movie',
      description: 'Put on a comedy movie or TV show to lighten up your mood. Laughter is a natural mood booster, and watching something funny can help you forget your worries for a while. A good laugh releases endorphins and reduces stress hormones. It also brings a positive shift in your mindset, allowing you to look at things more lightheartedly. Choose a movie you know will make you laugh out loud!',
      imagePath: 'assets/images/film.jpg',
      time: '90 mins',
    ),
    Activity(
      title: 'Listen to Uplifting Music',
      description: 'Put on some uplifting music that makes you feel good. Music has the power to alter our mood, and listening to positive, upbeat songs can have an immediate effect on how you feel. Let the rhythm and lyrics uplift you and provide comfort. Sing along or dance to the beat if you feel like it. Music can remind you that better days are ahead and you are not alone in your emotions.',
      imagePath: 'assets/images/music.jpg',
      time: '30 mins',
    ),
  ],
  'Stressed': [
    Activity(
      title: 'Yoga',
      description: 'Engage in gentle yoga to relax your body and mind. Yoga combines stretching, breathing, and relaxation techniques that reduce stress and anxiety. Practicing yoga can help you release physical tension, improve flexibility, and enhance your overall well-being. Even simple yoga poses, such as child’s pose or downward dog, can help you feel more relaxed and centered. Make sure to breathe deeply as you move through the poses.',
      imagePath: 'assets/images/yoga.jpg',
      time: '40 mins',
    ),
    Activity(
      title: 'Nature Walk',
      description: 'Take a walk in nature to clear your mind and get away from stressors. Walking outside helps reduce cortisol levels, which are linked to stress. Spending time in a natural setting can bring a sense of peace and tranquility, allowing you to disconnect from daily pressures. Observe the sights and sounds around you and focus on the beauty of the environment. Walking at a gentle pace will also help release endorphins.',
      imagePath: 'assets/images/nature.jpg',
      time: '25 mins',
    ),
    Activity(
      title: 'Breathing Exercises',
      description: 'Practice deep breathing to reduce stress and calm your nervous system. Controlled breathing has a direct effect on the body’s relaxation response, helping lower heart rate and blood pressure. Take deep breaths in through your nose, hold for a moment, and then exhale slowly through your mouth. Doing this exercise helps clear your mind, release tension, and provide immediate relief from stress. Make this a part of your daily routine.',
      imagePath: 'assets/images/breathing.jpg',
      time: '10 mins',
    ),
    Activity(
      title: 'Stretching',
      description: 'Do some simple stretches to release muscle tension and improve flexibility. Stretching your body helps alleviate physical discomfort caused by stress. It increases blood flow and helps you feel more at ease. Focus on areas where you tend to hold tension, such as your neck, shoulders, and back. Pair your stretches with deep breathing to maximize relaxation. Remember to stretch gently without overexerting yourself.',
      imagePath: 'assets/images/stretching.jpg',
      time: '15 mins',
    ),
    Activity(
      title: 'Soak in a Warm Bath',
      description: 'Take a warm bath to relax your muscles and soothe your mind. Soaking in warm water can help ease physical tension and calm an overactive mind. You can add essential oils like lavender or chamomile to enhance relaxation. Use this time to disconnect from all stressors and take care of yourself. Dim the lights, light a candle, and create a peaceful environment where you can fully unwind.',
      imagePath: 'assets/images/bath.jpg',
      time: '30 mins',
    ),
  ],
  'Anxious': [
    Activity(
      title: 'Art Therapy',
      description: 'Express your feelings through art and creative activities. Engaging in art helps channel your emotions in a productive and creative way. You don’t need to be an artist—just let your emotions guide your creation. Use colors that reflect your mood and let your imagination flow. Art therapy allows you to release pent-up feelings and gain insight into what is causing your anxiety. Focus on the process, not the result.',
      imagePath: 'assets/images/art.jpg',
      time: '50 mins',
    ),
    Activity(
      title: 'Listening to Music',
      description: 'Listen to calming music to soothe your mind and reduce anxiety. Choose instrumental or ambient music that is gentle and comforting. Let the sound wash over you and help you relax. You can close your eyes, lie down, and allow the music to guide your breathing. Music has a calming effect on the nervous system, helping to reduce feelings of anxiousness and bring you a sense of inner calm.',
      imagePath: 'assets/images/listen.jpg',
      time: '30 mins',
    ),
    Activity(
      title: 'Relaxation Techniques',
      description: 'Perform relaxation exercises to reduce anxiety and improve your mood. Techniques like progressive muscle relaxation and visualization help to ease tension and anxiety. Find a quiet space where you can focus without distractions, and practice tensing and relaxing each muscle group. Alternatively, visualize a peaceful setting like a beach or meadow. Relaxation techniques help you gain control over your body’s stress response.',
      imagePath: 'assets/images/relaxation.jpg',
      time: '25 mins',
    ),
    Activity(
      title: 'Guided Meditation',
      description: 'Try guided meditation to help release your anxious thoughts. Guided meditations provide instructions to help you focus on calming thoughts and sensations. You can find many meditation apps or videos online that guide you step-by-step through the process. The guidance helps anchor your thoughts and keep you from spiraling into negative thinking. Make sure you are comfortable and in a quiet place for meditation.',
      imagePath: 'assets/images/medi.jpg',
      time: '15 mins',
    ),
    Activity(
      title: 'Mindful Coloring',
      description: 'Color intricate designs in an adult coloring book to reduce anxiety. Coloring can help you focus on the present moment and keep your mind from wandering to anxious thoughts. Focusing on colors and patterns is a calming and meditative activity that provides a break from your worries. The repetitive motions of coloring are soothing, and the end result can be quite satisfying. You can color for as long as you want, depending on how you feel.',
      imagePath: 'assets/images/coloring.jpg',
      time: '45 mins',
    ),
  ],
};
