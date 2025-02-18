# Multi-Screen Form Validation in Flutter

## Overview
This Flutter application implements a multi-screen form validation system with two screens:

1. **Personal Info Screen** - Collects user's personal details such as name, age, and address.
2. **Contact Info Screen** - Collects user's contact details like email, phone number, and emergency contact.

Each screen includes validation rules for user input and allows seamless navigation between them. A confirmation dialog is displayed upon successful completion of the form.

## Features
- Multi-screen form with input validation.
- User-friendly navigation between screens.
- Error messages for invalid inputs.
- Confirmation dialog after form submission.

## Technologies Used
- Flutter (Dart)
- Flutter Form Validation
- Navigation and Routing

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/vpendo/Input_Validation.git   ```
2. Navigate to the project directory:
   ```sh
   cd Input_Validation
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```

## Screens
### Personal Info Screen
- Name (Required, min length: 3 characters)
- Age (Required, must be a valid number)
- Address (Required)

### Contact Info Screen
- Email (Required, must be a valid email format)
- Phone Number (Required, must be 10 digits)
- Emergency Contact (Optional but should be a valid phone number if provided)

## Future Enhancements
- **State Management:** Implement Provider or Riverpod for better state handling.
- **UI Enhancements:** Improve UI design with Material or Cupertino widgets.
- **Data Persistence:** Store user input using SharedPreferences or SQLite.
- **Better Error Handling:** Enhance error messages for better UX.

## Contributing
Contributions are welcome! Feel free to submit a pull request or report issues.

## License
This project is licensed under the MIT License.

## Contact
For any inquiries, contact (v.pendo@alustudent.com).


