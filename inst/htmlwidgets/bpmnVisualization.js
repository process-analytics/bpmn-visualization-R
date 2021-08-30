HTMLWidgets.widget({
    name: "bpmnVisualization",
    type: "output",

    factory: function(containerElt, width, height) {
        const bpmnVisualization = new bpmnvisu.BpmnVisualization({ container: containerElt, navigation: { enabled: true } });

        return {
            renderValue: function(x) {
                bpmnVisualization.load(x.bpmnContent, { fit: {type: bpmnvisu.FitType.Center, margin: 30} });

                // Add overlays
                x.overlays.map(overlay => {
                    const elementsByIds = bpmnVisualization.bpmnElementsRegistry.getElementsByIds(overlay.elementId);

                    if (elementsByIds) {
                        const overlayConfig = elementsByIds[0].bpmnSemantic.isShape ? {
                            position: 'top-center',
                            label: overlay.label,
                            style: {
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
                            }
                        } : {
                            position: 'middle',
                            label: overlay.label,
                            style: {
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
                            }
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
