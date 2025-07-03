FROM python:3.11-alpine

# Define o diretório de trabalho, para onde os arquivos serão copiados
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# A instalação das dependências só será executada novamente se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir: não armazena o cache do pip, mantendo a imagem menor.
# --upgrade pip: garante que estamos usando uma versão recente do pip.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado.
# Usamos --host 0.0.0.0 para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]