/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:BMI_calculator');

#import('dart:html');
#import('dart:math');
#source('view.dart');

class BMICalculator implements View {
    double lengthInCm;
    double weightInKg;

    DivElement container;
    SpanElement lengthLabel;
    SpanElement lengthUnitLabel;
    InputElement length;
    SpanElement weightLabel;
    SpanElement weightUnitLabel;
    InputElement weight;
    DocumentFragment fragment;
    OutputElement output;
    InputElement metric;
    InputElement imperial;
    SpanElement measurementSystemLabel;
    DivElement measurementSystemGroup;
    final double lbInKg = 0.45359237;
    final double inInCm = 2.54;
    bool isMetricMeasurement = true;
    DivElement descriptionContainer;
    ImageElement description;
    SVGCircleElement bmiMarker;

    BMICalculator() {
        initWidget();
        showBMI();
    }

    void showBMI() {
        calculateBMI();  // include it into the Start Activity
        positionBMIMarker(weightInKg, lengthInCm);
    }

    void initWidget() {
        initElements();
        attachElements();
        attachToRoot();

        attachShortcuts();
    }

    void attachShortcuts() {
        window.on.keyUp.add((final KeyboardEvent e) {
            if(e.keyIdentifier == 'Enter') {
                showBMI();
            } else if (e.keyIdentifier == 'U+001B') { // Esc key
                resetUi();
            }
        });

        window.on.keyPress.add((final KeyboardEvent e) {
        final String char = new String.fromCharCodes([e.charCode]);
            if(char == 'm') {
                if(!isMetricMeasurement) { // replace by on.change Event on the radio button, once supported
                    changeToMetric();
                    showBMI();
                }
            } else if (char == 'i') {
                if(isMetricMeasurement) { // replace by on.change Event on the radio button, once supported
                    changeToImperial();
                    showBMI();
                }
            }
        });
    }

    void changeToMetric() {
        metric.checked = true;
        isMetricMeasurement = true;

        lengthUnitLabel.text = 'in cm:';
        length.valueAsNumber = convertInToCm(length.valueAsNumber);
        weightUnitLabel.text = 'in kg:';
        weight.valueAsNumber = convertLbToKg(weight.valueAsNumber);
    }

    void changeToImperial() {
        imperial.checked = true;
        isMetricMeasurement = false;

        lengthUnitLabel.text = 'in in:';
        length.valueAsNumber = convertCmToIn(length.valueAsNumber);
        weightUnitLabel.text = 'in lb:';
        weight.valueAsNumber = convertKgToLb(weight.valueAsNumber);
    }

    void resetUi() {
        length.value = length.defaultValue;
        weight.value = weight.defaultValue;
        length.select();
    }

    void attachToRoot() {
        fragment = new DocumentFragment();
        fragment.elements.add(container);
    }

    void attachElements() {
        container = new DivElement();
        container.elements.add(measurementSystemLabel);
        container.elements.add(measurementSystemGroup);
        container.elements.add(lengthLabel);
        container.elements.add(lengthUnitLabel);
        container.elements.add(length);
        container.elements.add(weightLabel);
        container.elements.add(weightUnitLabel);
        container.elements.add(weight);
        container.elements.add(output);
        container.elements.add(descriptionContainer);
    }

    void initElements() {
        initmeasurementSystemChoice();
        initLengthLabel();
        initLengthInput();
        initWeightLabel();
        initWeightInput();
        initOutput();
        initDescription();
        initDescriptionOverlay();
    }

    double kgToXscale(final double kg) {
        final double kgStart = 40;
        final double xPerKg = 4.915;
        final double visibleWeight = kg - kgStart;

        return visibleWeight * xPerKg;
    }

    double cmToYscale(final double cm) {
        final double cmStart = 148;
        final double yPerCm = 9.22;
        final double visibleHeight = cm - cmStart;

        return visibleHeight * yPerCm;
    }

    void positionBMIMarker(final double kg, final double cm) {
        final double x = kgToXscale(kg);
        final double y = cmToYscale(cm);

        bmiMarker.attributes = {
           "cx": x, "cy": y, "fill":"#191", "stroke": '#119', "fill-opacity":.5, "r": 5
        };
    }

    void initDescriptionOverlay() {
        final int maxY = 480;
        final int maxX = 590;

        final SVGGElement svgGroup = new SVGElement.tag("g");
        svgGroup.attributes["transform"] = "translate(0, $maxY) scale(1,-1)";

        bmiMarker = new SVGElement.tag("circle");
        svgGroup.elements.add(bmiMarker);


        final SVGElement descriptionOverlay = new SVGElement.tag("svg");
        descriptionOverlay.elements.add(svgGroup);
        descriptionOverlay.attributes = {
           "height": maxY,
           "width": maxX,
           "version": "1.1"
        };

        descriptionContainer.elements.add(descriptionOverlay);
        descriptionOverlay.style.cssText = 'top: 202px; left: 58px; position: absolute;';
    }

    void initDescription() {
        descriptionContainer = new DivElement();
        description = new ImageElement('http://upload.wikimedia.org/wikipedia/commons/e/e9/Body_mass_index_chart.svg');
//        description = new ImageElement('http://upload.wikimedia.org/wikipedia/commons/e/e9/Body_mass_index_chart.svg', 690, 575);
        descriptionContainer.elements.add(description);
    }

    void initmeasurementSystemChoice() {
        measurementSystemLabel = new SpanElement();
        measurementSystemLabel.text = 'Measurement System';

        measurementSystemGroup = new DivElement();
        metric = new InputElement('radio');
        metric.name = 'measurementSystem';
        metric.defaultChecked = true;

        measurementSystemGroup.elements.add(metric);
        SpanElement metricContainer = new SpanElement();
        metricContainer.text = 'Metric (cm / kg)';
        metricContainer.title = 'm';
        measurementSystemGroup.elements.add(metricContainer);

        imperial = new InputElement('radio');
        imperial.name = 'measurementSystem';
        measurementSystemGroup.elements.add(imperial);
        SpanElement imperialContainer = new SpanElement();
        imperialContainer.text = 'Imperial (in / lb)';
        imperialContainer.title = 'i';
        measurementSystemGroup.elements.add(imperialContainer);
    }

    void calculateBMI() {
        setMetaValues();

        double bmi = weightInKg / Math.pow(lengthInCm, 2) * 1e4;
        output.value = 'BMI: ' + bmi.toStringAsFixed(2);
    }

    void setMetaValues() {
        if(isMetricMeasurement) {
            lengthInCm = length.valueAsNumber;
            weightInKg = weight.valueAsNumber;
        } else {
            convertMetricToImperial();
        }
    }

    double convertCmToIn(double cm) {
        return cm / inInCm; 
    }
    
    double convertKgToLb(double kg) {
        return kg / lbInKg;
    }

    double convertInToCm(double inches) {
        return inches * inInCm;
    }

    double convertLbToKg(double lb) {
        return lb * lbInKg;
    }

    void convertMetricToImperial() {
        lengthInCm = convertInToCm(length.valueAsNumber);
        weightInKg = convertLbToKg(weight.valueAsNumber);
    }

    void initLengthLabel() {
        lengthLabel = new SpanElement();
        lengthLabel.text = 'Length ';
        lengthUnitLabel = new SpanElement();
        lengthUnitLabel.text = 'in cm:';
    }

    void initWeightLabel() {
        weightLabel = new SpanElement();
        weightLabel.text = 'Weight ';
        weightUnitLabel = new SpanElement();
        weightUnitLabel.text = 'in kg:';
    }

    void initOutput() {
        output = new OutputElement();
        output.style.cssText = 'display: block';
        output.defaultValue = 'BMI';
    }

    void initLengthInput(){
        length = new InputElement('number');
        length.defaultValue = '185';
        length.required = true;
        length.style.cssText = 'color: red';

        length.style.cssText = 'display: block';

        length.on.change.add((final Event e) => showBMI());
    }

    void initLengthChoice() {

    }

    void initWeightInput(){
        weight = new InputElement('number');
        weight.defaultValue = '85';
        weight.required = true;

        weight.style.cssText = 'display: block';

        weight.on.change.add((final Event e) => showBMI());
    }

    DocumentFragment get root() => fragment;
}

void main() {
    final BMICalculator bmiCalculator = new BMICalculator();

    document.body.elements.add(bmiCalculator.root);
}