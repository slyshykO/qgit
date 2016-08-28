/*******************************************************************************
*  file    : common.cpp
*  created : 25.08.2016
*  author  : Slyshyk Oleksiy (alexSlyshyk@gmail.com)
*******************************************************************************/

#include "common.h"


BaseEvent::BaseEvent(SCRef d, int id) :
    QEvent(static_cast<QEvent::Type>(id)), payLoad(d)
{

}

BaseEvent::~BaseEvent()
{

}



MainExecErrorEvent::~MainExecErrorEvent()
{

}

DeferredPopupEvent::~DeferredPopupEvent()
{

}
