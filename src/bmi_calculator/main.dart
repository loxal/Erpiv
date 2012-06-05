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

    BMICalculator() {
        initWidget();
        calculateBMI();
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
                calculateBMI();
            } else if (e.keyIdentifier == 'U+001B') { // Esc key
                resetUi();
            }
        });

        window.on.keyPress.add((final KeyboardEvent e) {
        final String char = new String.fromCharCodes([e.charCode]);
            if(char == 'm') {
                if(!isMetricMeasurement) { // attach this to radiobutton change events so this check won't be necessary
                    changeToMetric();
                    calculateBMI();
                }
            } else if (char == 'i') {
                if(isMetricMeasurement) { // attach this to radiobutton change events so this check won't be necessary
                    changeToImperial();
                    calculateBMI();
                }
            }
        });
    }

    // http://en.wikipedia.org/wiki/File:Body_mass_index_chart.svg
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
    }

    void initElements() {
        initmeasurementSystemChoice();
        initLengthLabel();
        initLengthInput();
        initWeightLabel();
        initWeightInput();
        initOutput();
    }

    void initmeasurementSystemChoice() {
        measurementSystemLabel = new SpanElement();
        measurementSystemLabel.text = 'Measurement System';

        measurementSystemGroup = new DivElement();
        metric = new InputElement('radio');
        metric.name = 'measurementSystem';
        metric.defaultChecked = true;
        metric.on.select.add((final Event e) => prine(e));

        measurementSystemGroup.elements.add(metric);
        SpanElement metricContainer = new SpanElement();
        metricContainer.text = 'Metric (cm / kg)';
        measurementSystemGroup.elements.add(metricContainer);

        imperial = new InputElement('radio');
        imperial.name = 'measurementSystem';
        measurementSystemGroup.elements.add(imperial);
        SpanElement imperialContainer = new SpanElement();
        imperialContainer.text = 'Imperial (in / lb)';
        measurementSystemGroup.elements.add(imperialContainer);
    }

    void calculateBMI() {
        setMetaValues();

        double bmi = weightInKg / Math.pow(lengthInCm, 2) * 1e4;
        output.value = 'BMI: ' + bmi.toStringAsFixed(2) + ' = ' + bmi.toStringAsPrecision(2) + ' = ' + bmi.toStringAsExponential(2)  + ' = ' + bmi.toRadixString(2);
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

        length.on.change.add((final Event e) => calculateBMI());
    }

    void initLengthChoice() {

    }

    void initWeightInput(){
        weight = new InputElement('number');
        weight.defaultValue = '85';
        weight.required = true;

        weight.style.cssText = 'display: block';

        weight.on.change.add((final Event e) => calculateBMI());
    }

    DocumentFragment get root() => fragment;
}

void main() {
    final BMICalculator bmiCalculator = new BMICalculator();

    document.body.elements.add(bmiCalculator.root);
}