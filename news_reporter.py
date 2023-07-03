import psycopg2
from dotenv import load_dotenv
import os

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USERNAME = os.getenv("DB_USERNAME")
DB_PASSWORD = os.getenv("DB_PASSWORD")


def connect():
    conn = None
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USERNAME,
            password=DB_PASSWORD,
            port=DB_PORT,
        )
        return conn
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        if conn is not None:
            conn.close()
            print("Database connection closed.")


def query_news():
    try:
        news_list = []
        conn = connect()
        cur = conn.cursor()

        news_query = "SELECT id, headline, description, author FROM public.news_table"
        cur.execute(news_query)
        news_records = cur.fetchall()

        for row in news_records:
            news_list.append(
                {
                    "id": row[0],
                    "headline": row[1],
                    "description": row[2],
                    "author": row[3],
                }
            )
        return news_list
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn:
            cur.close()
            conn.close()
            print("Database connection closed.")
