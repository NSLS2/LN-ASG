#!../../bin/linux-x86_64/lnAsg

#- You may have to change lnAsg to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST","NO")
epicsEnvSet("EPICS_CA_ADDR_LIST","10.0.153.255")

## Register all support components
dbLoadDatabase "dbd/lnAsg.dbd"
lnAsg_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadRecords("db/asgDemo.db","SYS=LN-RF,D=TEST")
dbLoadRecords("db/iocAdminSoft.db", "IOC=RF-CT{${IOC}}")
dbLoadRecords("db/reccaster.db", "P=RF-CT{${IOC}-RC}")

# Auto save/restore

dbLoadRecords("db/save_restoreStatus.db", "P=RF-CT{${IOC}}")

save_restoreSet_status_prefix("RF-CT{${IOC}}")

asSetFilename("${TOP}/DEFAULT.acf")

## Run this to trace the stages of iocInit
#traceIocInit
ln
# ensure directories exist
system("install -d ${TOP}/as")
system("install -m 777 -d ${TOP}/as/save")
system("install -m 777 -d ${TOP}/as/req")

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass0_restoreFile("ioc_settings.sav")
set_pass0_restoreFile("ioc_values.sav")
set_pass1_restoreFile("ioc_values.sav")

cd "${TOP}/iocBoot/${IOC}"
iocInit

#dbl > records.dbl
#
#system "cp records.dbl /cf-update/linacioc04.${IOC}.dbl"

makeAutosaveFileFromDbInfo("${TOP}/as/req/ioc_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("${TOP}/as/req/ioc_values.req", "autosaveFields")

create_monitor_set("ioc_settings.req", 5, "")
create_monitor_set("ioc_values.req", 5, "")

caPutLogInit("10.0.152.133:7004", 1)

