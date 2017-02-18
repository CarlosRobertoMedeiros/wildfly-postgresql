FROM tonda100/wildfly-empty
MAINTAINER Antonin Stoklasek

ENV DATASOURCE_NAME ApplicationDS
ENV DATASOURCE_JNDI java:/ApplicationDS

ENV DB_HOST database
ENV DB_PORT 5432
ENV DB_USER user
ENV DB_PASS password
ENV DB_NAME dbname

# create temporary deployment dir, because wars can deploy after the datasource is created
RUN mkdir /tmp/deploments
ENV DEPLOY_DIR /tmp/deploments

COPY startWithPostgres.sh $WILDFLY_HOME/bin

USER root
RUN chown jboss:jboss $WILDFLY_HOME/bin/startWithPostgres.sh
RUN chmod 755 $WILDFLY_HOME/bin/startWithPostgres.sh
RUN yum -y install wget
USER jboss

RUN wget -P /tmp https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar

ENTRYPOINT $WILDFLY_HOME/bin/startWithPostgres.sh