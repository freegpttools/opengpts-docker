FROM node:18 AS frontend
WORKDIR /frontend
COPY ./opengpts/frontend .
RUN npm i
RUN npm run build

FROM python:3.11-slim
WORKDIR /backend
COPY ./opengpts/backend .
RUN rm poetry.lock
RUN pip install .
COPY --from=frontend /frontend/dist ./ui
CMD exec uvicorn app.server:app --host 0.0.0.0 --port $PORT