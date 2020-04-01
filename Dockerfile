FROM ruby

ARG VERSION
RUN gem install cfn-nag -v ${VERSION}

ENTRYPOINT ["cfn_nag_scan"]
CMD ["--help"]
