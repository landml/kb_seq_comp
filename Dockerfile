FROM kbase/sdkbase2:python
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

# RUN apt-get update


# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

# Install Mummer
RUN \
    curl -LJO https://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz && \
    tar xf MUMmer3.23.tar.gz && \
    mv MUMmer3.23 /kb/deployment/mummer && \
    cd /kb/deployment/mummer && make all && \
    echo 'export PATH=$PATH:/kb/deployment/mummer' >> /kb/deployment/user-env.sh

COPY tools/dnadiff_genomes.pl /kb/deployment/bin/dnadiff_genomes
RUN \
#    cp kb_seq_comp/tools/dnadiff_genomes.pl /kb/deployment/bin && \
#    mv /kb/deployment/bin/dnadiff_genomes.pl /kb/deployment/bin/dnadiff_genomes && \
    chmod a+x /kb/deployment/bin/dnadiff_genomes

WORKDIR /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
