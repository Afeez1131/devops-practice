# breaking installation when running /usr/local/maven3.9/bin/mvn install

# what worked:
```bash
export MAVEN_OPTS="-Dhttps.protocols=TLSv1.2 -Djdk.tls.client.protocols=TLSv1.2 -Xmx512m"
/usr/local/maven3.9/bin/mvn install \
  -Dmaven.wagon.http.retryHandler.count=5 \
  -Dmaven.wagon.httpconnectionManager.ttlSeconds=120 \
  -Dmaven.wagon.http.pool=false
```