From: https://github.com/APSL/docker-thumbor/issues/12#issuecomment-191765018
By @bf: https://github.com/bf

For AWS Beanstalk you need to create a `Dockerun.aws.json` file with the following contents. Create a new Beanstalk environment and simply upload the JSON file. 

```
{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "apsl/thumbor"
  },
 "Ports": [
    {
      "ContainerPort": "8000"
    }
  ]
}
```

As soon as the new environment is booted, you need to go to the configuration section where you can set the environment parameters for the docker container. There you should define the following environment variables to serve files from your AWS S3 Bucket through thumbor to your users (all environment params are listed on https://hub.docker.com/r/apsl/thumbor/ ).

```
AWS_ACCESS_KEY_ID=XXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXX
LOADER=tc_aws.loaders.s3_loader
S3_USE_SIGV4=True
TC_AWS_LOADER_BUCKET=bucket-name
TC_AWS_REGION=eu-central-1
```

If you want to store the files resized by thumbor on S3 as well, you need to add some more evironment params. We use a caching server in front of thumbor which solves the need for caching of result files in S3.

