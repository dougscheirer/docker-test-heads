FROM dscheirer/ruby23

RUN apt-get install -y postgresql-9.3 supervisor

# Now set up our supervisor runners
COPY *-supervisor.conf /etc/supervisor/conf.d/

# set up postgres to accept local connections
COPY pg_hba.conf /etc/postgresql/9.3/main/

# set up the source tree, then bundle install
RUN git clone https://github.com/dougscheirer/test-heads.git /test-head

# do this instead of clone when we're screwing around with local changes
# COPY test-head/ /test-head

# copy in the docker runner script
COPY docker-run.sh /usr/local/bin/

# bundle install
WORKDIR /test-head
ENV RACK_ENV=production
RUN bundle install --without development,test

CMD supervisord -c /etc/supervisor/supervisord.conf -n
EXPOSE 9292