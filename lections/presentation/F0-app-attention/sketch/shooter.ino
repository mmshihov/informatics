#define MOTOR_PIN A0

#define MODE0_LED_PIN 12
#define MODE1_LED_PIN 11
#define MODE2_LED_PIN 10

#define MODE_COUNT 3

#define SHOT_BUTTON_PIN 7
#define MODE_BUTTON_PIN 6

#define SLACK_SHOT_POWER 128

class CBltinBlinker {
public:
  CBltinBlinker() {
    mIsOn = true;
  }
  
  void setTime(unsigned long time) {
    mTime = time;
  }
  
  void blink(unsigned long time) {
    if (mIsOn) {
      if ((time - mTime) > ON_DELAY) {
        mTime = time;
        mIsOn = false;
        digitalWrite(LED_BUILTIN, LOW);
      }
    } else {
      if ((time - mTime) > OFF_DELAY) {
        mTime = time;
        mIsOn = true;
        digitalWrite(LED_BUILTIN, HIGH);
      }
    }
  }
  
private:
  unsigned long mTime;  
  bool mIsOn;
  static const unsigned long ON_DELAY = 2000;
  static const unsigned long OFF_DELAY = 500;
};

class CShotMode {
public:
  virtual void start(unsigned long time) = 0;
  virtual void shot(unsigned long time) = 0;
  virtual void stop() = 0;
};

class CSlackShotMode : public CShotMode {
public:
  virtual void start(unsigned long time) {
    mTime = time;
    analogWrite(MOTOR_PIN, 255);
  }
  
  virtual void shot(unsigned long time) {
    if ((time - mTime) > ON_DELAY) {
      mTime = time;
      this->stop();
    }
  }
  
  virtual void stop() { analogWrite(MOTOR_PIN, 0); }
private:  
  unsigned long mTime;
  static const unsigned int ON_DELAY = 500;  
};

class CPulseShotMode : public CShotMode {
public:
  virtual void start(unsigned long time) {
    mTime = time;
    mIsOn = true;
    analogWrite(MOTOR_PIN, 255);
  }
  
  virtual void shot(unsigned long time) {
    if (mIsOn) {
      if ((time - mTime) > ON_DELAY) {
        mTime = time;
        mIsOn = false;
        analogWrite(MOTOR_PIN, 0);
      }
    } else {
      if ((time - mTime) > OFF_DELAY) {
        mTime = time;
        mIsOn = true;
        analogWrite(MOTOR_PIN, 255);
      }
    }
  }
  
  virtual void stop() { analogWrite(MOTOR_PIN, 0); }
  
private:
  unsigned long mTime;
  bool mIsOn;

  static const unsigned int ON_DELAY = 1000;
  static const unsigned int OFF_DELAY = 500;
};

class CPowerShotMode : public CShotMode {
public:
  virtual void start(unsigned long /*time*/) {
    analogWrite(MOTOR_PIN, 255);
  }
  
  virtual void shot(unsigned long /*time*/) {}
  
  virtual void stop() { analogWrite(MOTOR_PIN, 0); }
};


class CApp {
public:
  CApp() {
    mModeIndex = 0;
    
    mShotPressedCount = 0;
    mModePressedCount = 0;
    
    mIsShotPressedOld = false;
    mIsModePressedOld = false;
    
    mModes[0] = &mSlackMode;    
    mModes[1] = &mPulseMode;    
    mModes[2] = &mPowerMode;    
  }
  
  void setTime(unsigned long time) {mTime = time; blinker.setTime(time); }
  
  void showCurrentMode() {
    for (int i=0; i<MODE_COUNT; i++) {
      digitalWrite(MODE_LED_PINS[i], LOW);
    }
    digitalWrite(MODE_LED_PINS[mModeIndex], HIGH);
  }
  
  void step() {
    unsigned long time = millis();
    
    if ((time - mTime) < 1) 
      return;

    mTime = time;

    blink();
    handleShiftMode();
    handleShot();
  }
  
private:
  unsigned long mTime;
  unsigned char mModeIndex;
  unsigned int mShotPressedCount;
  unsigned int mModePressedCount;
  bool mIsShotPressedOld;
  bool mIsModePressedOld;

  CBltinBlinker  blinker;
  
  CSlackShotMode mSlackMode;
  CPulseShotMode mPulseMode;
  CPowerShotMode mPowerMode;
  
  CShotMode *mModes[MODE_COUNT];
  unsigned int MODE_LED_PINS[MODE_COUNT] = {MODE0_LED_PIN, MODE1_LED_PIN, MODE2_LED_PIN};
  
  CShotMode *currentMode() { return mModes[mModeIndex]; }
  
  static const unsigned int BUTTON_PRESSED_PERIOD = 20;
  
  bool isShotPressed()   const { return mShotPressedCount >= (BUTTON_PRESSED_PERIOD - 1); }
  
  bool isShotUnPressed() const { return mShotPressedCount <= 1; }
  
  bool isModePressed()   const { return mModePressedCount >= (BUTTON_PRESSED_PERIOD - 1); }
  
  bool isModeUnPressed() const { return mModePressedCount <= 1; }

  void blink() { blinker.blink(mTime); }
  
  void countShotPressed() {
    if (digitalRead(SHOT_BUTTON_PIN) == HIGH) {
      if (mShotPressedCount < BUTTON_PRESSED_PERIOD) {
        mShotPressedCount++;
      }
    } else {
      if (mShotPressedCount > 1) {
        mShotPressedCount--;
      }
    }
  }
  
  void countModePressed() {
    if (digitalRead(MODE_BUTTON_PIN) == HIGH) {
      if (mModePressedCount < BUTTON_PRESSED_PERIOD) {
        mModePressedCount++;
      }
    } else {
      if (mModePressedCount > 1) {
        mModePressedCount--;
      }
    }
  }

  void handleShiftMode() {
    countModePressed();
    
    if ((! mIsModePressedOld) && isModePressed()) {
      mIsModePressedOld = true;
      mIsShotPressedOld = false;
      currentMode()->stop();
      
      mModeIndex = (mModeIndex + 1) % MODE_COUNT;
      
      showCurrentMode();
    } else if (mIsModePressedOld && isModeUnPressed()) {
      mIsModePressedOld = false;
    }
  }

  void handleShot() {
    countShotPressed();
    
    if ((! mIsShotPressedOld) && isShotPressed()) {
      mIsShotPressedOld = true;
      currentMode()->start(mTime);
    } else if (mIsShotPressedOld && isShotUnPressed()) {
      mIsShotPressedOld = false;
      currentMode()->stop();
    } else if (mIsShotPressedOld) {
      currentMode()->shot(mTime);
    }
  }
};

CApp app;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  
  pinMode(MODE0_LED_PIN, OUTPUT);
  pinMode(MODE1_LED_PIN, OUTPUT);
  pinMode(MODE2_LED_PIN, OUTPUT);
  
  pinMode(SHOT_BUTTON_PIN, INPUT);
  pinMode(MODE_BUTTON_PIN, INPUT);

  app.setTime(millis());
  app.showCurrentMode();
}

void loop() {
  app.step();
}
