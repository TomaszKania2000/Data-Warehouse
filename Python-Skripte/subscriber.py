""" Python-Project Uebung 1 Subscriber
    * Receive measurement data
    * Write Data to Database
    author:     Duerr,Max; Schulte,Alexander; Kania,Tomasz
    date:       04.11.2022
    version:    1.0
    license:    XXX
"""

import paho.mqtt.client as mqtt
import psycopg2

broker_address = "broker.hivemq.com"
broker_topic = "DataMgmt/FIN"
subscription_qos = 1

postgres_conn = psycopg2.connect(database="Data-Warehouse", user='postgres', password='superuser', host='localhost',
                                 port='5433')
cursor = postgres_conn.cursor()


def on_message(client, userdata, message):
    m_decode = str(message.payload.decode("utf-8", "ignore"))
    try:
        query_sql = "insert into staging.messung (payload) values (\'" + m_decode + "\')"
        cursor.execute(query_sql)
        postgres_conn.commit()
    except (Exception, psycopg2.Error) as error:
        print("Error:", error)


client = mqtt.Client("DHBW_DHW_GruppeLG4_Uebung1_Client_Subscriber_1_Alex", clean_session=False)
client.on_message = on_message
client.connect(broker_address)
client.subscribe(broker_topic, qos=subscription_qos)
client.loop_forever()
