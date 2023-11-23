FROM debian

COPY script.sh /
RUN chmod +x script.sh
RUN touch txt
CMD ["./script.sh"]
