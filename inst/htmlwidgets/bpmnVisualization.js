HTMLWidgets.widget({
    name: "bpmnVisualization",
    type: "output",

    factory: function(containerElt, width, height) {
        const bpmnVisualization = new bpmnvisu.BpmnVisualization({ container: containerElt, navigation: { enabled: true } });

        return {
            renderValue: function(data) {
            //    const bpmnContent = data.bpmnContent;
                const bpmnContent = '<?xml version="1.0" encoding="UTF-8"?>\n' +
                    '<bpmn:definitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" xmlns:di="http://www.omg.org/spec/DD/20100524/DI" id="Definitions_0wdqriz" targetNamespace="http://bpmn.io/schema/bpmn" exporter="bpmn-js (https://demo.bpmn.io)" exporterVersion="6.3.0">\n' +
                    '  <bpmn:collaboration id="Collaboration_186ohra">\n' +
                    '    <bpmn:participant id="Participant_18khpiz" name="pool" processRef="Process_0wpi11d" />\n' +
                    '    <bpmn:participant id="Participant_0sxdgkk" processRef="Process_0a3pw5m" />\n' +
                    '    <bpmn:messageFlow id="MessageFlow_1y9pbqo" sourceRef="Activity_0sphjzx" targetRef="Activity_0j11lp8" />\n' +
                    '  </bpmn:collaboration>\n' +
                    '  <bpmn:process id="Process_0wpi11d" isExecutable="false">\n' +
                    '    <bpmn:laneSet id="LaneSet_1i59xiy">\n' +
                    '      <bpmn:lane id="Lane_164yevk">\n' +
                    '        <bpmn:flowNodeRef>Event_17h5lf8</bpmn:flowNodeRef>\n' +
                    '      </bpmn:lane>\n' +
                    '      <bpmn:lane id="Lane_1h5yeu4" />\n' +
                    '      <bpmn:lane id="Lane_12u5n6x" name="toto">\n' +
                    '        <bpmn:flowNodeRef>Activity_0sphjzx</bpmn:flowNodeRef>\n' +
                    '      </bpmn:lane>\n' +
                    '    </bpmn:laneSet>\n' +
                    '    <bpmn:startEvent id="Event_17h5lf8">\n' +
                    '      <bpmn:outgoing>Flow_0n3te5s</bpmn:outgoing>\n' +
                    '    </bpmn:startEvent>\n' +
                    '    <bpmn:task id="Activity_0sphjzx" name="A">\n' +
                    '      <bpmn:incoming>Flow_0n3te5s</bpmn:incoming>\n' +
                    '    </bpmn:task>\n' +
                    '    <bpmn:sequenceFlow id="Flow_0n3te5s" sourceRef="Event_17h5lf8" targetRef="Activity_0sphjzx" />\n' +
                    '  </bpmn:process>\n' +
                    '  <bpmn:process id="Process_0a3pw5m">\n' +
                    '    <bpmn:task id="Activity_0j11lp8" name="B" />\n' +
                    '  </bpmn:process>\n' +
                    '  <bpmndi:BPMNDiagram id="BPMNDiagram_1">\n' +
                    '    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Collaboration_186ohra">\n' +
                    '      <bpmndi:BPMNShape id="Participant_18khpiz_di" bpmnElement="Participant_18khpiz" isHorizontal="true">\n' +
                    '        <dc:Bounds x="160" y="110" width="1260" height="320" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNShape id="Lane_164yevk_di" bpmnElement="Lane_164yevk" isHorizontal="true">\n' +
                    '        <dc:Bounds x="190" y="110" width="1230" height="83" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNShape id="Lane_1h5yeu4_di" bpmnElement="Lane_1h5yeu4" isHorizontal="true">\n' +
                    '        <dc:Bounds x="190" y="193" width="1230" height="83" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNShape id="Lane_12u5n6x_di" bpmnElement="Lane_12u5n6x" isHorizontal="true">\n' +
                    '        <dc:Bounds x="190" y="276" width="1230" height="154" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNShape id="Event_17h5lf8_di" bpmnElement="Event_17h5lf8">\n' +
                    '        <dc:Bounds x="352" y="142" width="36" height="36" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNShape id="Activity_0sphjzx_di" bpmnElement="Activity_0sphjzx">\n' +
                    '        <dc:Bounds x="310" y="290" width="100" height="80" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNEdge id="Flow_0n3te5s_di" bpmnElement="Flow_0n3te5s">\n' +
                    '        <di:waypoint x="370" y="178" />\n' +
                    '        <di:waypoint x="370" y="234" />\n' +
                    '        <di:waypoint x="360" y="234" />\n' +
                    '        <di:waypoint x="360" y="290" />\n' +
                    '      </bpmndi:BPMNEdge>\n' +
                    '      <bpmndi:BPMNShape id="Participant_0sxdgkk_di" bpmnElement="Participant_0sxdgkk" isHorizontal="true">\n' +
                    '        <dc:Bounds x="160" y="530" width="1260" height="270" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNShape id="Activity_0j11lp8_di" bpmnElement="Activity_0j11lp8">\n' +
                    '        <dc:Bounds x="350" y="620" width="100" height="80" />\n' +
                    '      </bpmndi:BPMNShape>\n' +
                    '      <bpmndi:BPMNEdge id="MessageFlow_1y9pbqo_di" bpmnElement="MessageFlow_1y9pbqo">\n' +
                    '        <di:waypoint x="360" y="370" />\n' +
                    '        <di:waypoint x="360" y="620" />\n' +
                    '      </bpmndi:BPMNEdge>\n' +
                    '    </bpmndi:BPMNPlane>\n' +
                    '  </bpmndi:BPMNDiagram>\n' +
                    '</bpmn:definitions>\n';
                bpmnVisualization.load(bpmnContent, { fit: {type: bpmnvisu.FitType.Center, margin: 30} });
            },
            resize: function(width, height) {
                // TODO: forward resize
            },

            // Make the bpmnVisualization object available as a property on the widget
            // instance we're returning from factory(). This is generally a
            // good idea for extensibility--it helps users of this widget
            // interact directly with bpmnVisualization, if needed.
            s: bpmnVisualization
        };
    }
});