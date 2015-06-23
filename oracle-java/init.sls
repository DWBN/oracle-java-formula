{% from "oracle-java/map.jinja" import java with context %}


webupd8team-java:
  pkgrepo.managed:
    - ppa: webupd8team/java
    - require_in:
      - pkg: oracle-java{{ java.version }}-installer
      - pkg: oracle-java{{ java.version }}-set-default
    - notify:
      - cmd: accept_licence


oracle-java{{ java.version }}-installer:
  pkg.installed


oracle-java{{ java.version }}-set-default:
  pkg.installed:
  - require:
    - pkg: oracle-java{{ java.version }}-installer

accept_licence:
  cmd.run:
    - name: echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
    - require_in:
      - pkg: oracle-java{{ java.version }}-installer
    - creates: /usr/lib/jvm/java-8-oracle





#jssecacerts:
#  file.managed:
#    - name: /usr/lib/jvm/java-8-oracle/jre/lib/security/jssecacerts
#    - source: salt://oracle-java/jssecacerts
#    - user: root
#    - require:
#      - pkg: oracle-java{{ java.version }}-installer
