FROM tutum/nginx
RUN rm /etc/nginx/sites-enabled/default
ADD sites-enabled/ /etc/nginx/sites-enabled
RUN chown -R www-data:www-data /app/
COPY ./wait-for-it.sh wait-for-it.sh