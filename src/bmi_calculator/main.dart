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
    DivElement container;
    SpanElement lengthLabel;
    InputElement length;
    SpanElement weightLabel;
    InputElement weight;
    ButtonElement calculateBMIButton;
    DocumentFragment fragment;
    OutputElement output;
    InputElement metric;
    InputElement imperial;
    SpanElement measureSystemLabel;
    DivElement measureSystemGroup;
    final double lbsInKg = 0.45359237;

    BMICalculator() {
        initWidget();
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
        container.elements.add(measureSystemLabel);
        container.elements.add(measureSystemGroup);
        container.elements.add(lengthLabel);
        container.elements.add(length);
        container.elements.add(weightLabel);
        container.elements.add(weight);
        container.elements.add(calculateBMIButton);
        container.elements.add(output);
    }

    void initElements() {
        initMeasureSystemChoice();
        initLengthLabel();
        initLengthInput();
        initWeightLabel();
        initWeightInput();
        initCalculateButton();
        initOutput();
    }

    void initMeasureSystemChoice() {
        measureSystemLabel = new SpanElement();
        measureSystemLabel.text = 'Measure System';

        measureSystemGroup = new DivElement();
        metric = new InputElement('radio');
        metric.name = 'measureSystem';
        metric.defaultChecked = true;
        metric.value = 'kg';
        metric.text = 'kage';
        measureSystemGroup.elements.add(metric);
        SpanElement metricContainer = new SpanElement();
        metricContainer.text = 'Metric (kg)';
        measureSystemGroup.elements.add(metricContainer);

        imperial = new InputElement('radio');
        imperial.name = 'measureSystem';
        imperial.value = 'lbs';
        imperial.text = 'elbes';
        measureSystemGroup.elements.add(imperial);
        SpanElement imperialContainer = new SpanElement();
        imperialContainer.text = 'Imperial (lbs)';
        measureSystemGroup.elements.add(imperialContainer);
    }

    void calculateBMI() {
        num bmi = weight.valueAsNumber / Math.pow(length.valueAsNumber, 2) * 1e4;
        output.value = bmi.toStringAsFixed(2);
    }

    void initLengthLabel() {
        lengthLabel = new SpanElement();
        lengthLabel.text = 'Length (in cm or in [RadioButton]): ';
    }

    void initWeightLabel() {
        weightLabel = new SpanElement();
        weightLabel.text = 'Weight (in kg or lbs [RadioButton]): ';
    }

    void initOutput() {
        output = new OutputElement();
        output.style.cssText = 'display: block';
        output.defaultValue = 'Your BMI.';
    }

    void initLengthInput(){
        length = new InputElement('number');
        length.defaultValue = '185';
        length.required = true;

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

    void initCalculateButton(){
        calculateBMIButton = new ButtonElement();
        calculateBMIButton.text = 'Calculate BMI';

        calculateBMIButton.on.click.add((final Event e) => calculateBMI());
    }

    DocumentFragment get root() => fragment;
}

void main() {
    final BMICalculator bmiCalculator = new BMICalculator();

    document.body.elements.add(bmiCalculator.root);
}