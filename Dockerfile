FROM php:8.3-cli

RUN apt-get update && apt-get install -y nodejs && apt-get install -y npm && apt-get install -y unzip

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install
RUN npm install
RUN npm run build
RUN touch database/database.sqlite

CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000
