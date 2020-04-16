FROM debian:latest



# Install OpenJDK-8
RUN apt-get update
RUN apt-get install sudo -y
RUN sudo add-apt-repository ppa:openjdk-r/ppa
RUN sudo apt-get update
RUN sudo apt-get install openjdk-8-jdk -y

# Setup JAVA_HOME -- useful for docker commandline
RUN sudo update-alternatives --config java
RUN JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
# ENV JAVA_HOME /usr/lib/jvm/java-1.11.0-openjdk-amd64/
RUN export JAVA_HOME
ENV PATH $PATH:$JAVA_HOME/bin
RUN export PATH

RUN echo $JAVA_HOME

RUN sudo apt-get install python3-pip -y

RUN sudo apt-get install wget -y

RUN wget https://services.gradle.org/distributions/gradle-6.3-bin.zip -P /tmp

RUN sudo apt-get install unzip -y

RUN sudo unzip -d /opt/gradle /tmp/gradle-*.zip

RUN echo 'export GRADLE_HOME=/opt/gradle/gradle-6.3' >> /etc/profile.d/gradle.sh
RUN echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' >> /etc/profile.d/gradle.sh
RUN sudo chmod +x /etc/profile.d/gradle.sh && /etc/profile.d/gradle.sh
# RUN  /etc/profile.d/gradle.sh
ENV GRADLE_HOME /opt/gradle/gradle-6.3
ENV PATH /opt/gradle/gradle-6.3/bin:${PATH}
RUN export GRADLE_HOME
RUN export PATH
RUN echo $GRADLE_HOME
RUN echo $PATH
RUN gradle -v
RUN sudo apt-get install curl -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
RUN aws --version