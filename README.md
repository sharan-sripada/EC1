# Rorschach Test App

This Flutter application is designed to conduct a Rorschach test. The Rorschach test is a psychological test in which subject's perceptions of inkblots are recorded and analyzed using psychological interpretation, complex algorithms, or both.

## Application Overview

The Rorschach Test App is intended to replicate the traditional Rorschach test process by presenting subjects with a inkblot image and prompting them to provide verbal interpretations. The app simplifies the Rorschach test process by presenting digital inkblot images and converting subject's verbal responses into text format using speech-to-text functionality. This digitization streamlines administration, eliminates the need for physical cards, and ensures efficient data capture.  The app also stores subject's responses for later analysis, enhancing its utility in psychological assessment.

## Features

1. **Image Display**: The app displays a Rorschach inkblot image on the screen. This image serves as the stimulus for the test.

2. **Speech Input**: Users are prompted to speak about what they see in the image. They can verbalize their interpretations, thoughts, or feelings related to the inkblot.

3. **Speech-to-Text Conversion**: The app uses the `speech_to_text` Flutter plugin to convert users' spoken responses into text format in real-time. This allows the app to capture and record users' interpretations of the inkblot.

4. **Storage of Responses**: Users' spoken responses are stored using the `shared_preferences` Flutter plugin. The responses are saved locally on the device for later analysis or review.

## Technologies Used

- **Flutter**: Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. It is used to develop the user interface and functionality of the app.

- **speech_to_text Plugin**: The `speech_to_text` Flutter plugin is used for performing speech-to-text conversion. It enables the app to transcribe users' spoken responses into text format.

- **shared_preferences Plugin**: The `shared_preferences` Flutter plugin is used for persisting key-value data. It is used to store and retrieve users' spoken responses locally on the device.

## Usage

To use the app, follow these steps:

1. Open the app on your device.
2. View the Rorschach inkblot image displayed on the screen.
3. Speak about what you see in the image. Share your interpretations, thoughts, or feelings related to the inkblot.
4. Your spoken response will be converted into text format and displayed on the screen.
5. Your response will be stored locally on the device for later analysis or review.

## Future Advancements

In future updates of the app, the stored responses could be used for further analysis. Potential advancements include:

 
- **Longitudinal Tracking**: By storing subject's responses over time, clinicians can track changes in psychological functioning and symptomatology longitudinally. This longitudinal tracking allows for the assessment of treatment effectiveness, identification of trends or progress, and adjustment of treatment plans as needed.

- **Data Analytics and Interpretation**: Clinicians can employ advanced data analytics techniques to analyze the collected responses systematically. By identifying patterns, themes, and emotional content within the responses, clinicians can gain a deeper understanding of subjects' psychological states and personality traits.

These advancements could enhance the app's functionality and provide a more comprehensive experience for users participating in the Rorschach test.
