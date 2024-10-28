# Dockerfile
FROM jenkins/jenkins:2.462.3-jdk17

USER root

# ติดตั้ง lsb-release สำหรับดึงข้อมูลรุ่นของระบบ
RUN apt-get update && apt-get install -y lsb-release

# ดึง GPG key ของ Docker
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# เพิ่ม Docker repository สำหรับการติดตั้ง Docker CLI
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# ติดตั้ง Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# ติดตั้ง Jenkins Plugins เช่น blueocean และ docker-workflow
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

# สลับกลับมาใช้ผู้ใช้ jenkins
USER jenkins