""" Python-Project Uebung 1 Publisher
    * Send measurement data
    author:     Duerr,Max; Schulte,Alexander; Kania,Tomasz
    date:       04.11.2022
    version:    1.0
    license:    XXX
"""

import datetime as dt
import random
import json
import time

import paho.mqtt.client as mqtt

broker_address = "broker.hivemq.com"
client = mqtt.Client("DHBW_DHW_GruppeLG4_Uebung1_Client_Publisher_1_Alex", clean_session=False)
client.connect(broker_address)


def generateDataToSend():
    fin = "WOL000051T2123456"
    geschwindigkeit = random.randint(0, 200)
    ort = 8

    zeit_jetzt = dt.datetime.now()
    zeit_formatted = zeit_jetzt.strftime("%d.%m.%Y %H:%M:%S.%f")
    zeit_cut = zeit_formatted[:-3]

    data_generated = {
        "fin": fin,
        "zeit": zeit_cut,
        "geschwindigkeit": geschwindigkeit,
        "ort": ort
    }
    data_generated_json = json.dumps(data_generated)
    return data_generated_json


while True:
    data_to_send = generateDataToSend()
    client.publish("DataMgmt/FIN", data_to_send, qos=0)
    print("published Data " + dt.datetime.now().strftime("%d.%m.%Y %H:%M:%S.%f"))
    print(data_to_send + "\n")
    time.sleep(5)
