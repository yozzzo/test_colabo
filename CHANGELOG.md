# Changelog

## Version 3.0.0 (2025-06-01)

### Major Changes
- **Fixed COLMAP OpenGL errors** in headless Colab environment
- **Switched to direct COLMAP commands** instead of using convert.py
- **Added CPU-only mode** for feature extraction to avoid GPU issues
- **Virtual display setup** using pyvirtualdisplay
- **Fallback PLY generation** ensures output even if COLMAP fails

### Technical Improvements
- Set PYOPENGL_PLATFORM='egl' for headless OpenGL
- Added QT_QPA_PLATFORM='offscreen' for Qt applications
- Reduced image size to 1024px and features to 2048 for faster processing
- Simplified validation to focus on essential checks
- Better error handling with detailed logging

### User Experience
- **Always produces a PLY file** - either from successful training or fallback
- Faster processing with reduced settings
- Clear progress indicators for each step
- Better error messages

### Known Issues Fixed
- "Check failed: context_.create()" OpenGL error
- "qt.qpa.plugin: Could not load Qt platform plugin" error
- COLMAP not found in PATH issues
- Training failures now handled gracefully

## Version 2.2.0 (2025-06-01)
- Attempted Qt fixes (superseded by v3.0.0)

## Version 2.1.0 (2025-06-01)
- Fixed duplicate cells and COLMAP installation

## Version 2.0.1 (2025-06-01)
- Initial version with version tracking