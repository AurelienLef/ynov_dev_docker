FROM node:18-alpine
WORKDIR /app

COPY --from=builder /app/node_modules /app/node_modules

COPY ../app.js ./

EXPOSE 3000
CMD ["npm", "start"]