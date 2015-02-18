# -*- coding:utf-8 -*-

# Copyright 2015 NEC Corporation.                                          #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#   http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #

from org.o3project.odenos.core.component.network.flow.basic.flow_action import (
    FlowAction
)


class OFPFlowActionSetQueue(FlowAction):
    # property key
    QUEUE_ID = "queue_id"

    def __init__(self, type_, queue_id):
        super(OFPFlowActionSetQueue, self).__init__(type_)
        self._body[self.QUEUE_ID] = queue_id

    @property
    def queue_id(self):
        return self._body[self.QUEUE_ID]

    @classmethod
    def create_from_packed(cls, packed):
        return cls(packed[cls.TYPE], packed[cls.QUEUE_ID])

    def packed_object(self):
        return self._body
