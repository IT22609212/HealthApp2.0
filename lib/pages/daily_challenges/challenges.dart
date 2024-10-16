List<Map<String, dynamic>> challenges = [
  {
    "title": "Relax",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 50,
    "isPaused": false, // Track if timer is paused
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions":
            "Get into a comfortable position, relax your mind, and close your eyes.",
        "duration": 5,
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Perform 30 minutes of cardio or strength training.",
        "duration": 30,
      },
      "Hard": {
        "time": "45 min",
        "instructions": "Perform 45 minutes of intense cardio.",
        "duration": 45,
      }
    }
  },
  {
    "title": "Draw",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Sketch something simple, like a fruit or flower.",
        "duration": 5
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Create a detailed drawing or doodle.",
        "duration": 30
      },
      "Hard": {
        "time": "60 mi",
        "instructions": "Work on a complex drawing or painting project.",
        "duration": 60
      }
    }
  },
  {
    "title": "Drink",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 20,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions":
            "Drink a glass of water and add a slice of lemon for flavor.",
        "duration": 5
      },
      "Medium": {
        "time": "15 min",
        "instructions":
            "Prepare a fruit-infused water with your favorite fruits.",
        "duration": 15
      },
      "Hard": {
        "time": "30 min",
        "instructions":
            "Create a hydration plan for the day, including 2 liters of water.",
        "duration": 30
      }
    }
  },
  {
    "title": "Walk",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 5,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Take a leisurely stroll around your neighborhood.",
        "duration": 5
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Walk briskly in a park or on a treadmill.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Hike on a challenging trail or long-distance walk.",
        "duration": 60
      }
    }
  },
  {
    "title": "Stretch",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 20,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Do basic stretches for your neck and shoulders.",
        "duration": 5
      },
      "Medium": {
        "time": "15 min",
        "instructions": "Follow a gentle full-body stretching routine.",
        "duration": 15
      },
      "Hard": {
        "time": "30 min",
        "instructions": "Engage in a yoga session focused on flexibility.",
        "duration": 30
      }
    }
  },
  {
    "title": "Read",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "10 min",
        "instructions": "Read a few pages of a light book or article.",
        "duration": 10
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Read a chapter from a novel or nonfiction book.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Engage with a challenging book or academic paper.",
        "duration": 60
      }
    }
  },
  {
    "title": "Breathe",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions":
            "Sit comfortably, take deep breaths, and focus on your breathing.",
        "duration": 5
      },
      "Medium": {
        "time": "15 min",
        "instructions":
            "Practice mindfulness meditation focusing on your breath.",
        "duration": 15
      },
      "Hard": {
        "time": "30 min",
        "instructions": "Engage in guided breathwork or pranayama exercises.",
        "duration": 30
      }
    }
  },
  {
    "title": "Cook",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "10 min",
        "instructions": "Prepare a simple snack, like a sandwich or salad.",
        "duration": 10
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Cook a quick meal, such as pasta or stir-fry.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Prepare a complex recipe or bake a dessert.",
        "duration": 60
      }
    }
  },
  {
    "title": "Listen",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Listen to your favorite song and enjoy the moment.",
        "duration": 5
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Listen to a podcast episode or an audiobook.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Explore a complex musical piece or lecture.",
        "duration": 60
      }
    }
  },
  {
    "title": "Write",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 30,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "10 min",
        "instructions": "Jot down your thoughts in a journal.",
        "duration": 10
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Draft a short story or blog post.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Work on a detailed essay or creative writing piece.",
        "duration": 60
      }
    }
  },
  {
    "title": "Play",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 50,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "10 min",
        "instructions": "Play a casual game or do a puzzle.",
        "duration": 10
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Engage in a competitive game or activity.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Participate in a challenging game or sport.",
        "duration": 60
      }
    }
  },
  {
    "title": "Focus",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 10,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Spend a few minutes clearing your mind and centering.",
        "duration": 5
      },
      "Medium": {
        "time": "20 min",
        "instructions": "Concentrate on a specific task or project.",
        "duration": 20
      },
      "Hard": {
        "time": "45 min",
        "instructions": "Deep dive into a complex task with no distractions.",
        "duration": 45
      }
    }
  },
  {
    "title": "Meditate",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 10,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions":
            "Sit quietly and focus on your breath for a few minutes.",
        "duration": 5
      },
      "Medium": {
        "time": "20 min",
        "instructions": "Practice a guided meditation session.",
        "duration": 20
      },
      "Hard": {
        "time": "45 min",
        "instructions":
            "Engage in a deep meditation practice, focusing on your thoughts.",
        "duration": 45
      }
    }
  },
  {
    "title": "Reflect",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Think about your day and what went well.",
        "duration": 5
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Write a reflection on recent experiences.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Analyze personal goals and long-term aspirations.",
        "duration": 45
      },
    }
  },
  {
    "title": "Organize",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "10 min",
        "instructions": "Tidy up your desk or a small area of your space.",
        "duration": 10
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Organize your closet or a larger room.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Declutter and reorganize your entire living space.",
        "duration": 60
      }
    }
  },
  {
    "title": "Connect",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "5 min",
        "instructions": "Send a quick message to a friend or family member.",
        "duration": 5
      },
      "Medium": {
        "time": "30 min",
        "instructions":
            "Call or video chat with someone you haven't spoken to in a while.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Plan a catch-up meeting or gathering with friends.",
        "duration": 60
      }
    }
  },
  {
    "title": "Explore",
    "isDone": false,
    "isExpanded": false,
    "timeRemaining": 0,
    "progress": 25,
    "isPaused": false,
    "priority": false,
    "difficulty": {
      "Easy": {
        "time": "10 min",
        "instructions": "Look up a new place you'd like to visit.",
        "duration": 10
      },
      "Medium": {
        "time": "30 min",
        "instructions": "Take a walk in a new neighborhood or park.",
        "duration": 30
      },
      "Hard": {
        "time": "60 min",
        "instructions": "Plan a day trip to a nearby city or attraction.",
        "duration": 60
      }
    }
  }

  // More challenges...
];
