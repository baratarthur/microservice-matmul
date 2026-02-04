FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5050

# O comando agora chama o gunicorn. 
# Sintaxe: gunicorn --bind [IP]:[PORTA] [NOME_DO_ARQUIVO]:[VARIAVEL_APP]
CMD ["gunicorn", "--workers", "4", "--bind", "0.0.0.0:5050", "app:app"]