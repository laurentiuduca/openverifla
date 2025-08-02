"""
Author: L.-C. Duca
SPDX-License-Identifier: GPL-2.0

20221017-1620
remove extra indent from two instructions 
which affected correct groupSize generation
"""
import sys
import serial
import json
from array import *
from datetime import datetime

def getProperties() :
    global jsondata, octetsPerWord, memWordLenBits, dataWordLenBits, clonesWordLenBits, memWords, portName, baudRate, timescaleUnit, timescalePrecision, clockPeriod, totalSignals, signalGroups, groupName, groupSize, groupEndian, totalmemoryDataBytes, triggerMatchMemAddr


    # Opening JSON file
    f = open(propertiesFileName)

    # returns JSON object as a dictionary
    jsondata = json.load(f)

    # close file
    f.close()

    # Iterating through the json list
    portName = jsondata['portName']
    baudRate = jsondata['baudRate']
    timescaleUnit = jsondata['timescaleUnit']
    timescalePrecision = jsondata['timescalePrecision']
    clockPeriod = jsondata['clockPeriod']

    totalSignals = jsondata['totalSignals']
    signalGroups = jsondata['signalGroups']
    cnt = 0
    sumOfSignals = 0
    groupName=[]
    groupSize=[]
    groupEndian=[]
    for i in jsondata['groups']:
        groupName.append(i['groupName'])
        groupSize.append(i['groupSize'])
        groupEndian.append(i['groupEndian'])
        sumOfSignals += groupSize[cnt]
        cnt = cnt + 1
    if(sumOfSignals != totalSignals):
        print("sumOfSignals != totalSignals: %d, %d" % sumOfSignals % totalSignals)
        sys.exit()
    #else:
    #    print("sumOfSignals = %d" % sumOfSignals)

    memWords = jsondata['memWords']
    dataWordLenBits = jsondata['dataWordLenBits']
    clonesWordLenBits = jsondata['clonesWordLenBits']
    if((dataWordLenBits % 8) or (clonesWordLenBits % 8)):
        print("error: dataWordLenBits or clonesWordLenBits are not multiple of 8\n")
        sys.exit()
    if(dataWordLenBits != totalSignals):
        print("error: totalSignals != dataWordLenBits")
        sys.exit()
    memWordLenBits = dataWordLenBits + clonesWordLenBits
    octetsPerWord = int(memWordLenBits / 8)
    if (memWordLenBits % 8 > 0):
        octetsPerWord += 1
    # compute values
    totalmemoryDataBytes = memWords*octetsPerWord
    triggerMatchMemAddr = jsondata['triggerMatchMemAddr']


def rebuildCapturedDataFromFile():
    global memoryLineBytes
    print("rebuildCapturedDataFromFile")    
    f = open(sourceToRebuildCaptureFile)
    i = 0
    # loop through the file line by line:
    for line in f:
        words = line.split(' ')
        aux1 = []
        k = 0
        for val in words:
            if(k == 0):
                k = 1
                continue
            if(val == "\n"):
                continue
            x = int(val, 16)
            aux1.append(x)
        # reverse array
        aux2 = aux1[::-1]
        memoryLineBytes.insert(i, aux2)
        i += 1
    f.close()

    #for r in memoryLineBytes:
    #    p = r[::-1]
    #    for c in p:
    #        print(hex(c),end = " ")
    #    print()


def getCapturedData():
    global memoryLineBytes, sendRunCommand

    ser=serial.Serial(portName, baudRate)
    if(ser.isOpen()):
        ser.close()
    ser.open()

    if(sendRunCommand == 1):
        auxi = USERCMD_RUN;
        x = auxi.to_bytes(1, 'little')
        print("Sending user_run command..");
        ser.write(x);
        print("Done sending user_run command.");
    else:
        print("sendRunCommand=%d" %sendRunCommand)

    # Read Captured data
    print("Waiting for data capture:");
    mlb = [[]]
    k = 0
    if(k == 0): # sol a
        rawByte = ser.read(memWords * octetsPerWord)
        for i in range(memWords):
            #print("i=%d" %i, end=" ")
            aux1 = []
            for j in range(octetsPerWord-1,-1,-1):
                aux1.append(rawByte[i*octetsPerWord+j])
            #print(aux1)
            aux2 = aux1[::-1]
            mlb.insert(i, aux2)
    else: # sol b
        for i in range(memWords):
            aux1 = []
            for j in range(octetsPerWord):
                x = ser.read()
                y = x.hex()
                z = int(y,16)
                aux1.append(z)
            mlb.insert(i, aux1)
    print("Data receive end.");

    for i in range(memWords):
        aux = mlb[memWords-1 -i]
        for j in range(octetsPerWord):
            memoryLineBytes.insert(i, aux)

    # Debug
    if(not debugVeriFLA):
        ser.close()
        return 0
		
    print("Received data:");
    for i in range(memWords):
        print("%03d: " %i, end=" ");
        for j in range(octetsPerWord-1,-1,-1):
            print("%02x " %(memoryLineBytes[i][j]), end=" ")
        print("\n")

    ser.close()

def saveCapturedData():
    # compute module name
    now = datetime.now()
    now2 = str(now).split(':')
    s = ""
    j = 0
    for i in now2:
        s += i
    s2 = s.split(' ')
    s3 = ""
    j = 0;
    for i in s2:
        s3 += i
        if (j == 0):
            s3 +="_"
        j = 1
    s4 = s3.split('-')
    s5 = ''
    for i in s4:
        s5 += i
    s6 = s5.split('.')
    s7 = s6[0]
    moduleName="capture_"+s7;
    outputFileName = moduleName+".v"

    # create file
    f = open(outputFileName, "w")

    # Write the timescale directive.
    strLine = "`timescale " + str(timescaleUnit) + " / " + str(timescalePrecision) + "\n\n";
    f.write(strLine);

    # Write the module name and output params.
    strLine = "module " + moduleName + "(clk_of_verifla, la_trigger_matched, ";
    for i in range(signalGroups):
        strLine += groupName[i]
        if(i != (signalGroups - 1)) :
            strLine += ", "
    strLine += ", memory_line_id"
    strLine += ");\n\n"
    f.write(strLine)

    # Write the declaration of signals
    strLine = "output clk_of_verifla;\n" + "output la_trigger_matched;\n" + "output ["+str(int(memWords/4))+":0] memory_line_id;\n"
    f.write(strLine)
    for k in range(2):
        for i in range(signalGroups):
            if(k == 0):
                strLine = "output "
            else:
                strLine = "reg ";
            if(groupSize[i] > 1) :
                if(groupEndian[i] != 0) :
                    strLine += "[0:"+str(groupSize[i]-1)+"] "
                else:
                    strLine += "["+str(groupSize[i]-1)+":0] "
            strLine += groupName[i] + ";\n"
            f.write(strLine)
    strLine = "reg ["+str(int(memWords/4))+":0] memory_line_id;\n" + \
        "reg la_trigger_matched;\n" + \
        "reg clk_of_verifla;" + "\n\n" + \
        "parameter PERIOD = " + str(clockPeriod) + ";" + "\n"
    f.write(strLine)

    # Write the clock task.
    strLine =  "initial    // Clock process for clk_of_verifla" + "\n" + \
        "begin" + "\n" + \
        "    forever" + "\n" + \
        "    begin" + "\n" + \
        "        clk_of_verifla = 1'b0;" + "\n" + \
        "        #("+ str(int(clockPeriod / 2)) + "); clk_of_verifla = 1'b1;" + "\n" + \
        "        #("+ str(int(clockPeriod / 2)) + ");" + "\n" + \
        "    end" + "\n" + "end" + "\n\n"
    f.write(strLine);

    # write dump.vcd
    strLine =  "initial " + "\n" + \
        "begin" + "\n" + \
        "    $dumpfile(\"dump.vcd\");" + "\n" + \
        "    $dumpvars();" + "\n" + \
        "end" + "\n\n"
    f.write(strLine);

    # Write captured data
    strLine = "initial begin\n"
    strLine += "#("+ str(int(clockPeriod / 2)) + ");\n"
    strLine += "la_trigger_matched = 0;\n"
    f.write(strLine)

    # Compute the name of the signals
    signalsToken = "{"
    for i in range(signalGroups-1, -1, -1) :
        signalsToken += groupName[i]
        if (i > 0) :
            signalsToken += ","
    signalsToken += "} = "

    # Write name of the signals, values and delays in the verilog file.
    strWord = ""
    currentTime=int(clockPeriod / 2)
    delay = 0

    # compute the oldest wrote-info before trigger event
    bt_queue_head_address = 0
    bt_queue_tail_address = 0
    # the word at address (memWords-1) represents bt_queue_tail_address.
    for j in range (octetsPerWord) :
        bt_queue_tail_address += ((0x000000FF) & memoryLineBytes[memWords-1][j]) << (8*j)
    if(debugVeriFLA):
        print("bt_queue_tail_address=%d" %bt_queue_tail_address)

    # Find the first <efffective capture memory word>
    # before the trigger event (not an <emtpy-slot> memory word).
    if(bt_queue_tail_address == (triggerMatchMemAddr - 1)) :
        bt_queue_head_address = 0
    else :
        bt_queue_head_address = bt_queue_tail_address + 1
    before_trigger=True
    foundAnEffectiveCaptureWord=False
    wentBack=False
    i = bt_queue_head_address;
    #print("bt_queue_head_address=%d" %i)
    while True :
        for j in range (octetsPerWord) :
            if(memoryLineBytes[i][j] != 0) :
                foundAnEffectiveCaptureWord = True
                #print("foundAnEffectiveCaptureWord i=%d j=%d memoryLineBytes[i][j]=%x" %(i ,j, memoryLineBytes[i][j]))
        if(foundAnEffectiveCaptureWord):
            break
        i += 1
        if(i >= triggerMatchMemAddr):
            if(not foundAnEffectiveCaptureWord and not wentBack):
                i = 0
                wentBack = True

        if (i > triggerMatchMemAddr):
            break

    if(not foundAnEffectiveCaptureWord) :
        print("Could not find the first efffective capture before trigger match");
        sys.exit()
    if(i >= triggerMatchMemAddr):
        before_trigger=False;

	
    # Walk through the captured data and write it to capture.v	
    while True :
        # Check if this is an empty line
        allMemoryLineIsZero=True
        for j in range (octetsPerWord-1, -1, -1):
            if(memoryLineBytes[i][j] != 0):
                allMemoryLineIsZero = False
                break
		
        if(allMemoryLineIsZero) :
            if(debugVeriFLA) :
                strLine = "// info: line "+str(i)+" is empty.\n"
                print(strLine)
                f.write(strLine)		
        else :
	    # Write memory line index.
            strLine = "memory_line_id=" + str(i) + ";\n"
            f.write(strLine);
	    # Data capture
            strWord = str(totalSignals) + "'b";
            for j in range (octetsPerWord-1,-1,-1):
                if((j * 8) < dataWordLenBits):
                    for k in range (7,-1,-1) :
                        if((j*8+k) < totalSignals) :
                            strWord += str((memoryLineBytes[i][j] >> k) & 1);
				
            strWord += ';';
            strLine = signalsToken + strWord + "\n";
            if(i == triggerMatchMemAddr):
                strLine += "la_trigger_matched = 1;\n";
            f.write(strLine);

	    # Time interval in which data is constant.
            delay=0;
            for j in range (octetsPerWord) :
                if((j * 8) >= dataWordLenBits) :
                    delay += (0x000000FF & memoryLineBytes[i][j]) << (8*j - dataWordLenBits);
				
            currentTime += delay * clockPeriod;
            strLine = "#" + str(delay * clockPeriod) + ";\n";
            f.write(strLine);
            # Also write the time stamp
            strLine = "// -------------  Current Time:  " + str(currentTime) + "*(" + str(timescaleUnit) + ") "+"\n";
            f.write(strLine);
	
	# Compute the new value of i
        if(before_trigger) :
            i = (i+1) % triggerMatchMemAddr;
            if(i == bt_queue_head_address) :
                before_trigger = False;
                i = triggerMatchMemAddr;
        else :
            i = i + 1;
        if (i >= (memWords-1)):
            break

    strLine = "$stop;\nend\nendmodule\n";	
    f.write(strLine);	

    # Write raw memory information.		
    strLine = "/*\n"+STR_ORIGINAL_CAPTURE_DUMP+"\n";	
    for i in range(memWords):
        strLine += "memory_line_id=" + str(i) + ": ";
        for j in range (octetsPerWord-1,-1,-1):
            #if((0x000000FF & memoryLineBytes[i][j]) <= 0x0F) :
            #    strLine += "0";
            strLine += str(hex(0x000000FF & memoryLineBytes[i][j])) + " "
            #strLine = strLine.upper()
        strLine += "\n";
    strLine += "*/\n";
    f.write(strLine);	
				
    f.close();
    print("Job done. Please simulate " + outputFileName +  " and after that see dump.vcd");

def job() :
    getProperties()
    #print("octetsPerWord=%d" %octetsPerWord)
    if(sourceToRebuildCaptureFile != ""):
        rebuildCapturedDataFromFile()
    else:
        getCapturedData()
    saveCapturedData()

# main
#print("received %d arguments" % len(sys.argv))
if(len(sys.argv) < 2) :
    print("Too few arguments: "+str(len(sys.argv)-1)+
	"\nSintax is:\n\tpython3 VeriFLA.py <propertiesFileName> [<sendRunCommand>=0/1 (default 0)]\n"+
	"Examples:\n1. Wait for FPGA to send capture:\n\tpython3 VeriFLA.py verifla_properties_keyboard.json\n"+
	"2. Send to the monitor the run command and wait for FPGA to send capture:\n\tpython3 VeriFLA.py verifla_properties_keyboard.json 1\n")
    sys.exit()
    
propertiesFileName = sys.argv[1]
print ("Reading propertiesFileName="+sys.argv[1])
if(len(sys.argv) >= 3):
    sendRunCommand = int(sys.argv[2])
else:
    sendRunCommand = 0
if(len(sys.argv) >= 4):
    sourceToRebuildCaptureFile = sys.argv[3];
else:
    sourceToRebuildCaptureFile = ""

USERCMD_RUN = 0x01
STR_ORIGINAL_CAPTURE_DUMP = "ORIGINAL CAPTURE DUMP"
memoryLineBytes = [[]]
debugVeriFLA = False
job()



