#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM centos:7
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
# If necessary, you need to set up a proxy, fill in the correct ip:port
#ENV http_proxy='ip:port' https_proxy='pi:port'


RUN yum makecache && yum install -y tzdata openssl curl ca-certificates fontconfig gzip tar && yum update -y && yum clean all

ARG JAVA_VERSION
ARG BINARY_URL="https://mirrors.huaweicloud.com/kunpeng/archive/compiler/bisheng_jdk/bisheng-jdk-${JAVA_VERSION}-linux-aarch64.tar.gz"

RUN set -ex; \
    echo $BINARY_URL; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    curl -LfsSo /tmp/openjdk.tar.gz.sha256 ${BINARY_URL}.sha256; \
    echo "`cat /tmp/openjdk.tar.gz.sha256` */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"
