FROM node:20-alpine

# Добавляем необходимые пакеты для сборки капризных библиотек типа sqlite3
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    py3-setuptools \
    sqlite-dev

WORKDIR /app

# Копируем зависимости
COPY package*.json ./

# Устанавливаем их (теперь Python найдет нужные модули для сборки)
RUN npm install

# Копируем остальной код
COPY . .

EXPOSE 3000

# Сначала создаем папку для статики, чтобы не было ошибки из логов
RUN mkdir -p /app/dist

# Собираем фронтенд (стили, скрипты)
RUN npm run build

CMD ["npm", "start"]
