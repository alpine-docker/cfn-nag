# After Travis CI adjusts their plan, we don't have enough free credit to run the build. So daily build has been adjusted to weekly. If you don't get latest version, please wait for one week.

# Linting tool for CloudFormation templates

Auto-trigger docker build for [Linting tool for CloudFormation templates](https://github.com/stelligent/cfn_nag) when new release is announced

[![DockerHub Badge](http://dockeri.co/image/alpine/cfn-nag)](https://hub.docker.com/r/alpine/cfn-nag/)

## NOTES

The latest docker tag is the latest release verison (https://github.com/cfn-nag/cfn-nag/releases/latest)

Please avoid to use `latest` tag for any production deployment. Tag with right version is the proper way, such as `alpine/cfn-nag:0.5.33`

### Github Repo

https://github.com/alpine-docker/cfn-nag

### Daily Travis CI build logs

https://travis-ci.com/alpine-docker/cfn-nag

### Docker image tags

https://hub.docker.com/r/alpine/cfn-nag/tags/

# Usage

    # mount local folders in container.
    docker run -ti --rm -v $(pwd):/apps -w /apps alpine/cfn-nag -i .

    # run container as command
    alias cfn_nag_scan="docker run -ti --rm -v $(pwd):/apps -w /apps alpine/cfn-nag"
    cfn_nag_scan --help

# sample output

```
--------
| WARN W47
|
| Resources: ["SNSAllConfigurationTopic", "SNSNotification"]
| Line Numbers: [45, 76]
|
| SNS Topic should specify KmsMasterKeyId property
------------------------------------------------------------
| FAIL F5
|
| Resources: ["AdditionalManagedIAMPolicy"]
| Line Numbers: [42]
|
| IAM managed policy should not allow * action
------------------------------------------------------------
```

# reference

https://stelligent.com/2018/03/23/validating-aws-cloudformation-templates-with-cfn_nag-and-mu/

# Why we need it

Mostly it is used during CI/CD (continuous integration and continuous delivery) or as part of an automated build/deployment

# The Processes to build this image

* Enable Travis CI cronjob on this repo to run build daily on master branch
* Check if there are new tags/releases announced via Github REST API
* Match the exist docker image tags via Hub.docker.io REST API
* If not matched, build the image with release version and push to https://hub.docker.com/
* Get the latest version from https://github.com/stelligent/cfn_nag/releases/latest, pull the image with that version, tag as `alpine/cfn-nag:latest` and push to hub.docker.com
