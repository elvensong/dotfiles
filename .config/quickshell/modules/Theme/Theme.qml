pragma Singleton
import QtQuick

QtObject {
  // Base colors
  property color background: "#ffffff"         // Pure white background
  property color surface: "#f2f2f2"            // Light gray for panels
  property color border: "#dddddd"             // Subtle border color

  // Accent and text
  property color primary: "#1976d2"            // Blue accent
  property color textPrimary: "#212121"        // Near-black text
  property color textSecondary: "#616161"      // Gray secondary text

  // Status indicators
  property color success: "#388e3c"
  property color warning: "#fbc02d"
  property color error: "#d32f2f"

  // Fonts
  property string fontFamily: "Fira Code"
  property int fontSize: 12

  // Transparency (for blur/opacity effects if used)
	property real opacity: 0.95

	property int borderRadius: 6
	property int spacing: 6
	property int padding: 8
}
