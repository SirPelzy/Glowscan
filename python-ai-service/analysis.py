import cv2
import mediapipe as mp
import numpy as np

# Initialize MediaPipe Face Mesh
mp_face_mesh = mp.solutions.face_mesh
face_mesh = mp_face_mesh.FaceMesh(static_image_mode=True, max_num_faces=1, min_detection_confidence=0.5)

def analyze_skin(image: np.ndarray):
    """
    Analyzes a facial image to estimate skin metrics like wrinkles, pores, and hydration.
    
    Args:
        image (np.ndarray): The input image in OpenCV format (BGR).

    Returns:
        dict: A dictionary containing the analysis results. Returns None if no face is found.
    """
    # Convert the BGR image to RGB
    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    
    # Process the image and find face landmarks
    results = face_mesh.process(rgb_image)

    if not results.multi_face_landmarks:
        return None # No face detected

    # Get landmarks for the first face
    landmarks = results.multi_face_landmarks[0].landmark
    h, w, _ = image.shape

    # --- 1. Wrinkle Analysis (Forehead Area) ---
    # Using landmarks for the forehead region
    forehead_points = [103, 104, 69, 108, 151, 337, 299, 333, 332]
    forehead_x = [int(landmarks[p].x * w) for p in forehead_points]
    forehead_y = [int(landmarks[p].y * h) for p in forehead_points]
    
    if forehead_x and forehead_y:
        x, y, w_roi, h_roi = cv2.boundingRect(np.array([[px, py] for px, py in zip(forehead_x, forehead_y)]))
        forehead_roi = image[y:y+h_roi, x:x+w_roi]
        wrinkle_score = estimate_wrinkles(forehead_roi)
    else:
        wrinkle_score = 0.0

    # --- 2. Pore Analysis (Cheek Area) ---
    # Using landmarks for the right cheek
    cheek_points = [132, 215, 213, 117, 118, 119]
    cheek_x = [int(landmarks[p].x * w) for p in cheek_points]
    cheek_y = [int(landmarks[p].y * h) for p in cheek_points]

    if cheek_x and cheek_y:
        x, y, w_roi, h_roi = cv2.boundingRect(np.array([[px, py] for px, py in zip(cheek_x, cheek_y)]))
        # Take a smaller, more consistent patch from the center of the cheek ROI
        cx, cy = x + w_roi // 2, y + h_roi // 2
        patch_size = 40
        cheek_patch = image[cy - patch_size//2 : cy + patch_size//2, cx - patch_size//2 : cx + patch_size//2]
        pore_score = estimate_pores(cheek_patch)
    else:
        pore_score = 0.0

    # --- 3. Hydration/Texture Analysis (simulated) ---
    # We can use the same cheek patch to estimate texture. Smoother texture implies better hydration.
    if 'cheek_patch' in locals() and cheek_patch.size > 0:
        hydration_score = estimate_texture(cheek_patch)
    else:
        hydration_score = 0.0

    return {
        "wrinkles": round(wrinkle_score, 2),
        "pores": round(pore_score, 2),
        "hydration": round(hydration_score, 2),
        "analysis_status": "success"
    }

def estimate_wrinkles(roi: np.ndarray):
    """Simulates wrinkle detection using Canny edge detection."""
    if roi.size == 0: return 0.0
    gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
    # Apply a Gaussian blur to reduce noise before edge detection
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    # Canny edge detection
    edges = cv2.Canny(blurred, 50, 150)
    # The score is the percentage of the area covered by edges (wrinkles)
    wrinkle_level = (np.sum(edges > 0) / (edges.shape[0] * edges.shape[1])) * 100
    # Scale to a 0-10 score
    return min(wrinkle_level * 2.5, 10.0)

def estimate_pores(roi: np.ndarray):
    """Simulates pore detection by analyzing high-frequency details."""
    if roi.size == 0: return 0.0
    gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
    # Use a high-pass filter (Laplacian) to find sharp details like pores
    laplacian = cv2.Laplacian(gray, cv2.CV_64F)
    # The variance of the laplacian gives a measure of detail/blurriness
    variance = laplacian.var()
    # Normalize to a 0-10 score. Higher variance = more visible pores.
    pore_score = np.clip((variance / 100), 0, 10)
    return pore_score

def estimate_texture(roi: np.ndarray):
    """Simulates hydration by measuring skin texture smoothness."""
    # This is the inverse of the pore score logic. Smoother texture = lower variance.
    pore_score = estimate_pores(roi)
    # Invert the score: a high pore score means low hydration/smoothness.
    hydration_score = 10.0 - pore_score
    return hydration_score
