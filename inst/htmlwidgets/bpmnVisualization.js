HTMLWidgets.widget({
    name: "bpmnVisualization",
    type: "output",

    factory: function(containerElt, width, height) {
        const bpmnVisualization = new bpmnvisu.BpmnVisualization({ container: containerElt, navigation: { enabled: true } });

        return {
            renderValue: function(bpmnContent) {
                bpmnVisualization.load(bpmnContent, { fit: {type: bpmnvisu.FitType.Center, margin: 30} });
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