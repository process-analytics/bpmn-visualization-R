/*
Copyright 2021 Bonitasoft S.A.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

HTMLWidgets.widget({
    name: "bpmnVisualizationR",
    type: "output",

    factory: function(containerElt, width, height) {
        const bpmnVisualization = new bpmnvisu.BpmnVisualization({ container: containerElt, navigation: { enabled: true } });

        function buildDefaultOverlayStyle(isShape) {
            if(isShape) {
                return {
                    font: {
                        color: 'White',
                        size: 14,
                    },
                    fill: {
                        color: 'rgba(54,160,54)',
                    },
                    stroke: {
                        color: 'rgba(54,160,54)',
                    }
                };
            }

            return {
                font: {
                    color: 'White',
                    size: 18,
                },
                fill: {
                    color: 'rgba(170,107,209)',
                },
                stroke: {
                    color: 'rgba(170,107,209)',
                }
            };
        }

        return {
            renderValue: function(x) {
                bpmnVisualization.load(x.bpmnContent, { fit: {type: bpmnvisu.FitType.Center, margin: 30} });
                // Add overlays
                x.overlays?.map(overlay => {
                    const elementsByIds = bpmnVisualization.bpmnElementsRegistry.getElementsByIds(overlay.elementId);

                    if (elementsByIds.length) {
                        const overlayConfig = {
                            label: overlay.label,
                            style: overlay.style ?? (x.enableDefaultOverlayStyle && buildDefaultOverlayStyle(elementsByIds[0].bpmnSemantic.isShape)),
                            position: elementsByIds[0].bpmnSemantic.isShape ? 'top-center' : 'middle',
                        };

                        bpmnVisualization.bpmnElementsRegistry.addOverlays(overlay.elementId, overlayConfig);
                    }
                });
            },
            resize: function(width, height) {
                // TODO: forward resize
            },

            // Make the bpmnVisualization object available as a property on the widget instance we're returning from factory().
            // This is generally a good idea for extensibility--it helps users of this widget interact directly with bpmnVisualization, if needed.
            s: bpmnVisualization
        };
    }
});
