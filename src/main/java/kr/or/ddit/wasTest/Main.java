package kr.or.ddit.wasTest;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static jdk.nashorn.internal.objects.NativeDebug.map;

class CreateBucket {

    public CreateBucket(String bucket) {
        try {
            AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                    .withCredentials(new ProfileCredentialsProvider())
                    .build();

            if (!s3Client.doesBucketExistV2("finalproject003")) {
                // Because the CreateBucketRequest object doesn't specify a region, the
                // bucket is created in the region specified in the client.
                s3Client.createBucket(new CreateBucketRequest("finalproject003"));

                // Verify that the bucket was created by retrieving it and checking its location.
                String bucketLocation = s3Client.getBucketLocation(new GetBucketLocationRequest("finalproject003"));
                System.out.println("Bucket location: " + bucketLocation);
            }
        } catch (AmazonServiceException e) {
            // The call was transmitted successfully, but Amazon S3 couldn't process
            // it and returned an error response.
            e.printStackTrace();
        } catch (SdkClientException e) {
            // Amazon S3 couldn't be contacted for a response, or the client
            // couldn't parse the response from Amazon S3.
            e.printStackTrace();
        }
    }
}

class DeleteBucket {
    public DeleteBucket(String bucketName) {
        try {
            AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                    .withCredentials(new ProfileCredentialsProvider())
                    .build();

            // Delete all objects from the bucket. This is sufficient
            // for unversioned buckets. For versioned buckets, when you attempt to delete objects, Amazon S3 inserts
            // delete markers for all objects, but doesn't delete the object versions.
            // To delete objects from versioned buckets, delete all of the object versions before deleting
            // the bucket (see below for an example).
            ObjectListing objectListing = s3Client.listObjects(bucketName);
            while (true) {
                Iterator<S3ObjectSummary> objIter = objectListing.getObjectSummaries().iterator();
                while (objIter.hasNext()) {
                    s3Client.deleteObject(bucketName, objIter.next().getKey());
                }

                // If the bucket contains many objects, the listObjects() call
                // might not return all of the objects in the first listing. Check to
                // see whether the listing was truncated. If so, retrieve the next page of objects
                // and delete them.
                if (objectListing.isTruncated()) {
                    objectListing = s3Client.listNextBatchOfObjects(objectListing);
                } else {
                    break;
                }
            }

            // Delete all object versions (required for versioned buckets).
            VersionListing versionList = s3Client.listVersions(new ListVersionsRequest().withBucketName(bucketName));
            while (true) {
                Iterator<S3VersionSummary> versionIter = versionList.getVersionSummaries().iterator();
                while (versionIter.hasNext()) {
                    S3VersionSummary vs = versionIter.next();
                    s3Client.deleteVersion(bucketName, vs.getKey(), vs.getVersionId());
                }

                if (versionList.isTruncated()) {
                    versionList = s3Client.listNextBatchOfVersions(versionList);
                } else {
                    break;
                }
            }

            // After all objects and object versions are deleted, delete the bucket.
            s3Client.deleteBucket(bucketName);
        } catch (
                AmazonServiceException e) {
            // The call was transmitted successfully, but Amazon S3 couldn't process
            // it, so it returned an error response.
            e.printStackTrace();
        } catch (
                SdkClientException e) {
            // Amazon S3 couldn't be contacted for a response, or the client couldn't
            // parse the response from Amazon S3.
            e.printStackTrace();
        }
    }
}

class PutObject{
    private String bucket_name;
    private String file_path;

    public PutObject() {
        this.bucket_name="finalproject001";
    }
    public void uploadFile(String file_path){
    	
        this.file_path=file_path;
        String key_name = Paths.get(file_path).getFileName().toString();

        System.out.format("Uploading %s to S3 bucket %s...\n", file_path, bucket_name);
        final AmazonS3 s3 = AmazonS3ClientBuilder.defaultClient();
        try {
            s3.putObject(bucket_name, key_name, new File(file_path));
        } catch (AmazonServiceException e) {
            System.err.println(e.getErrorMessage());
            System.exit(1);
        }
        System.out.println("Done!");
    }
}

class getObject{
    private String bucket_name;
    final AmazonS3 s3 = AmazonS3ClientBuilder.defaultClient();

    public getObject() {
        this.bucket_name = "finalproject001";
    }
    public void connectStream(String filename){
        try {
            S3Object o = s3.getObject(bucket_name, filename);
            S3ObjectInputStream s3is = o.getObjectContent();
//            s3is.read();
            s3is.close();
        } catch (AmazonServiceException e) {
            System.err.println(e.getErrorMessage());
            System.exit(1);
        } catch (
                FileNotFoundException e) {
            System.err.println(e.getMessage());
            System.exit(1);
        } catch (IOException e) {
            System.err.println(e.getMessage());
            System.exit(1);
        }
        System.out.println("Done!");
    }
}

public class Main {

    public static void main(String[] args) throws IOException, InterruptedException {
//        FFprobe ffprobe = new FFprobe("D:/ffmpeg/bin/ffprobe.exe");
//        FFmpegProbeResult probeResult = ffprobe.probe("https://s3.ap-northeast-2.amazonaws.com/finalproject001/%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98/12.%EA%B3%84%EC%88%98+%EC%A0%95%EB%A0%AC(Counting+Sort)");
//
//        FFmpegFormat format = probeResult.getFormat();
//        System.out.format("%nFile: '%s' ; Format: '%s' ; Duration: %ds",
//                format.filename,
//                format.format_long_name,
//                (int)format.duration
//        );
//
//        FFmpegStream stream = probeResult.getStreams().get(0);
//        System.out.format("%nCodec: '%s' ; Width: %dpx ; Height: %dpx",
//                stream.codec_long_name,
//                stream.width,
//                stream.height
//        );
        Map<String,String> map=new HashMap<>();
        map("abc",null);
        System.out.println(map.get("abc"));
        //new PutObject().uploadFile("C:/Users/PC23/Downloads/동영상모음/알고리즘/[알고리즘]1-1.알고리즘의 개념.mp4");
        //new getObject().connectStream("[알고리즘]1-1.알고리즘의 개념.mp4");
        
        ObjectMetadata ob = new ObjectMetadata();
       
        ob.setContentLength( new File("D:\\DHRDF\\leng.sql").length());
        PutObjectRequest p = new PutObjectRequest("finalproject001", "testFile", new FileInputStream("D:\\DHRDF\\leng.sql"),ob);
        AmazonS3ClientBuilder.defaultClient().putObject(p);        

    }
}
