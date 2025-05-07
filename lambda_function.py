import boto3
#import json
from PIL import Image
import io
#import os


s3 = boto3.client("s3")

def lambda_handler(event, context):
    source_bucket = "image-source-bucket"
    processed_bucket = "image-processed-bucket"

    for record in event['Records']:
        file_key = record['s3']['object']['key']
#Downloading the image file from s3
        response = s3.get_object(Bucket=source_bucket, Key=file_key)
        image_data = response['Body'].read()
#resizing the image
        with Image.open(io.BytesIO(image_data)) as IMG:
#Checking for the compatability
		    IMG = IMG.convert('RGB')
#Resizing the image to 256*256 pixels 
        IMG = IMG.resize((256, 256))  
#Saving the resized image to temp
        temp = io.BytesIO()
        IMG.save(temp, format="JPEG")
        temp.seek(0)

#uploading the processed image to processed-bucket/destination_bucket
        s3.put_object(
            Bucket=processed_bucket,
            Key=f"processed_{file_key}",
            Body=temp,
            ContentType="image/jpeg"
        )

    return {
	"statusCode": 200, 
	"body": "Image processed successfully"}
	
}
