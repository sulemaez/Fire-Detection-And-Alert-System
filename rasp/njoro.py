# Using Android IP Webcam video .jpg stream (tested) in Python2 OpenCV3

import urllib.request as request
import urllib
import cv2 as cv
import numpy as np
import time
import socketio
import base64
import time
from multiprocessing import Process

#url to wend alert to
urlSpring = 'http://localhost:8080/alert'
alerted = False #to decided if to send or not 

def alerter():
    global alerted
    while True:
        time.sleep(30)

    
p1 = Process(target=alerter, name='alerter')
p1.start()
#setup socket io to transfer images
sio = socketio.Client()

@sio.event
def connect():
    sio.emit('setname','postaNjoro')

@sio.event
def connect_error():
    print("The connection failed!")
    print("\n")
@sio.event
def disconnect():
    print("I'm disconnected!")



#setup the model params
confidence_threshold = 0.25
mms_threshold = 0.40
inp_width = 416
inp_height = 416

classes_file = 'fire.txt'
classes = None

with open(classes_file,'rt') as f:
    classes = f.read().rstrip('\n').split('\n')

#mode weights and conf
model_conf = 'yt.cfg'
model_weights = 'yt6.weights'

#get model
net = cv.dnn.readNetFromDarknet(model_conf,model_weights)
net.setPreferableBackend(cv.dnn.DNN_BACKEND_OPENCV)
net.setPreferableTarget(cv.dnn.DNN_TARGET_CPU)


#gets the output names of the model 
def getOutputsNames(net):
    layer_names = net.getLayerNames()
    return [layer_names[i[0] - 1] for i in net.getUnconnectedOutLayers()]

def postProcess(img,outs):
    global alerted
    frame_height = img.shape[0]
    frame_width = img.shape[1]

    class_ids = []
    confidences = []
    boxes = []

    for out in outs:
        for detection in out:
            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = scores[class_id]


            if confidence > confidence_threshold:
                center_x = int(detection[0] * frame_width)
                center_y = int(detection[1] * frame_height)


                width =  int(detection[2] * frame_width)
                height = int(detection[3] * frame_height)

                left = int(center_x - width/2)
                top = int(center_y - height/2)

                class_ids.append(class_id)
                confidences.append(float(confidence))
                boxes.append([left,top,width,height])

                if not alerted:
                    alerted = True
                    print("SENT ALERT")
                    data = urllib.parse.urlencode({"name": "postaNjoro"})
                    data = data.encode('ascii')
                    response = urllib.request.urlopen(urlSpring, data)
                
    
    indices = cv.dnn.NMSBoxes(boxes,confidences,confidence_threshold,mms_threshold)

    for i in indices:
        i = i[0]
        box = boxes[i]
        left = box[0]
        top = box[1]
        width = box[2]
        height = box[3]
        
        drawPred(class_ids[i],confidences[i],left,top,left + width,top + height,img) 


def drawPred(class_id,conf,left,top,right,bottom,img):
    cv.rectangle(img,(left,top),(right,bottom),(255,178,50),3)

    label = "%.2f" % conf

    if classes:
        assert(class_id <  len(classes))

        label = "%s:%s" % (classes[class_id],label)

    cv.putText(img,label,(left,top),cv.FONT_HERSHEY_PLAIN,1,(255,255,255),1) 


def sendImage(frame):
    retval, buffer = cv.imencode('.png', frame)
    jpg_as_text = base64.b64encode(buffer)
    sio.emit('image',str(jpg_as_text)[2:-1])


#URL to camera
cap = cv.VideoCapture('vid.mp4')
sio.connect('http://localhost:5000')

while(True):

    ret, frame = cap.read() 
  
    if ret:
        #send model
        sendImage(frame)
        time.sleep(0.4)  
    else:
       print('no video')
       cap.set(cv.CAP_PROP_POS_FRAMES, 0)

      

    if cv.waitKey(1) & 0xFF == ord('q'):
        break


cap.release()
cv.destroyAllWindows()