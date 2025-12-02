FROM mysql:8.0.44

# Copy decrypted initialization script (will be decrypted by Jenkins before build)
COPY db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql

# Create a non-root user with UID 1000 for file ownership
RUN groupadd -g 1000 mysqlapp && \
    useradd -r -u 1000 -g mysqlapp mysqlapp && \
    chown -R mysqlapp:mysqlapp /docker-entrypoint-initdb.d && \
    chmod 644 /docker-entrypoint-initdb.d/db_backup.sql && \
    chmod 755 /docker-entrypoint-initdb.d

EXPOSE 3306


# Environment variables (MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD) 
# will be provided at runtime (via docker run -e or K8s secrets)
CMD ["mysqld"]