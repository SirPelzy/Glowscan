from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
import numpy as np
import cv2
from analysis import analyze_skin

app = FastAPI(
    title="GlowScan AI Skin Analysis Service",
    description="An API that analyzes facial images to provide skin health metrics.",
    version="1.0.0"
)

@app.get("/", tags=["Health Check"])
async def read_root():
    """A simple health check endpoint."""
    return {"status": "GlowScan AI Service is running"}

@app.post("/analyze", tags=["Analysis"])
async def analyze_image(file: UploadFile = File(...)):
    """
    Receives an image, performs skin analysis, and returns a JSON result.
    """
    # Ensure the uploaded file is an image
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File provided is not an image.")

    try:
        # Read the contents of the uploaded file
        contents = await file.read()
        
        # Convert the image data to a numpy array
        np_arr = np.frombuffer(contents, np.uint8)
        
        # Decode the numpy array into an OpenCV image
        img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

        if img is None:
            raise HTTPException(status_code=400, detail="Could not decode the image file.")

        # Perform the skin analysis
        analysis_result = analyze_skin(img)

        if analysis_result is None:
            raise HTTPException(status_code=404, detail="Could not detect a face in the provided image.")

        return JSONResponse(content=analysis_result)

    except Exception as e:
        # Catch-all for any other errors during processing
        raise HTTPException(status_code=500, detail=f"An internal server error occurred: {str(e)}")
