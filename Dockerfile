FROM lavkesh/nginx:1.0

COPY build/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /cloud-ui/template
COPY build/dist/js/app*.*.js /cloud-ui/template/

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]