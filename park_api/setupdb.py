import psycopg2

from park_api import db

def main():
    db.init()
    #with psycopg2.connect(**env.DATABASE) as conn:
    #    cursor = conn.cursor()
    #    cursor.execute('CREATE TABLE "public"."parkapi" ('
    #                   '"id" SERIAL,'
    #                   '"timestamp_updated" TIMESTAMP NOT NULL,'
    #                   '"timestamp_downloaded" TIMESTAMP NOT NULL,'
    #                   '"city" TEXT NOT NULL,"data" JSON NOT NULL,'
    #                   'PRIMARY KEY ("id"))'
    #                   'TABLESPACE "pg_default";')
    #    conn.commit()

if __name__ == "__main__":
    main()
