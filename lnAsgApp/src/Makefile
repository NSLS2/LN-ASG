TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = lnAsg
# lnAsg.dbd will be created and installed
DBD += lnAsg.dbd

# lnAsg.dbd will be made up from these files:
lnAsg_DBD += base.dbd

# Include dbd files from all support applications:
lnAsg_DBD += asSupport.dbd
lnAsg_DBD += calcSupport.dbd
lnAsg_DBD += caPutLog.dbd
lnAsg_DBD += devIocStats.dbd
lnAsg_DBD += system.dbd
lnAsg_DBD += reccaster.dbd
lnAsg_DBD += s7plc.dbd

# Add all the support libraries needed by this IOC
lnAsg_LIBS += s7plc asyn calc caPutLog sscan devIocStats autosave reccaster seq pv pvDatabase qsrv pvaClient pvAccessIOC pvAccess pvAccessCA nt pvData

# lnAsg_registerRecordDeviceDriver.cpp derives from lnAsg.dbd
lnAsg_SRCS += lnAsg_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
lnAsg_SRCS_DEFAULT += lnAsgMain.cpp
lnAsg_SRCS_vxWorks += -nil-

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    lnAsg_LIBS += qsrv
    lnAsg_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    lnAsg_DBD += PVAServerRegister.dbd
    lnAsg_DBD += qsrv.dbd
endif

# Add support from base/src/vxWorks if needed
#lnAsg_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
lnAsg_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

