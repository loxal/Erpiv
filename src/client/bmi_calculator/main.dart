/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

library net.loxal.BMI_calculator;

import 'dart:html';
import '../core/core.dart';
import '../core/view.dart';
import 'dart:svg';
import 'dart:svg' as svg;
import 'dart:math';

class BMICalculator extends Core implements View {
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
  svg.ImageElement description;
  CircleElement bmiMarker;

  BaseElement base;

  BMICalculator() {
    initWidget();
    showBMI();
  }

  void showBMI() {
    calculateBMI(); // include it into the Start Activity
    positionBMIMarker(weightInKg, lengthInCm);
  }

  void initWidget() {
    initElements();
    attachElements();
    attachToRoot();

    attachShortcuts();
  }

  void attachShortcuts() {
    window.onKeyUp.listen((final KeyboardEvent e) {
      if (e.keyCode == 'Enter') {
        showBMI();
      } else if (e.keyCode == 'U+001B') {
        // Esc key
        resetUi();
      }
    });

    window.onKeyPress.listen((final KeyboardEvent e) {
      final String char = new String.fromCharCodes([e.charCode]);
      if (char == 'm') {
        if (!isMetricMeasurement) {
          // replace by on.change Event on the radio button, once supported
          calculateMetricBMI();
        }
      } else if (char == 'i') {
        if (isMetricMeasurement) {
          // replace by on.change Event on the radio button, once supported
          calculateImperialBMI();
        }
      }
    });
  }

  void calculateMetricBMI() {
    changeToMetric();
    showBMI();
  }

  void calculateImperialBMI() {
    changeToImperial();
    showBMI();
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
    fragment.append(container);
  }

  void attachElements() {
    container = new DivElement();
    container.append(measurementSystemLabel);
    container.append(measurementSystemGroup);
    container.append(lengthLabel);
    container.append(lengthUnitLabel);
    container.append(length);
    container.append(weightLabel);
    container.append(weightUnitLabel);
    container.append(weight);
    container.append(output);
    container.append(descriptionContainer);
  }

  void initElements() {
    initMeasurementSystemChoice();
    initLengthLabel();
    initLengthInput();
    initWeightLabel();
    initWeightInput();
    initOutput();
    initDescription();
    initDescriptionOverlay();
  }

  double kgToXscale(final double kg) {
    final double kgStart = 40.0;
    final double xPerKg = 4.915;
    double visibleWeight = kg - kgStart;

    return visibleWeight * xPerKg;
  }

  double cmToYscale(final double cm) {
    final double cmStart = 148.0;
    final double yPerCm = 9.22;
    final double visibleHeight = cm - cmStart;

    return visibleHeight * yPerCm;
  }

  void positionBMIMarker(final double kg, final double cm) {
    final double x = kgToXscale(kg);
    final double y = cmToYscale(cm);

    bmiMarker.attributes = {
        'cx': x.toStringAsFixed(0),
        'cy': y.toStringAsFixed(0),
        'fill': '#191', 'stroke': Core.standardColor, 'fill-opacity': "0.5", 'r': "5"
    };
  }

  final int yMax = 480;
  final int xMax = 590;

  void initDescriptionOverlay() {
    final SvgElement svgGroup = new SvgElement.tag('g');
    svgGroup.attributes['transform'] = 'translate(0, $yMax) scale(1,-1)';

    bmiMarker = new SvgElement.tag('circle');
    svgGroup.append(bmiMarker);

    final SvgElement descriptionOverlay = new SvgElement.tag('svg');
    descriptionOverlay.append(svgGroup);
    descriptionOverlay.attributes = {
        'height': yMax.toString(),
        'width': xMax.toString(),
    };

    descriptionContainer.append(descriptionOverlay);
    descriptionOverlay.style.cssText = 'top: 163px; left: 13px; position: absolute;';
  }

  void initDescription() {
    svg.SvgSvgElement svgBase = new svg.SvgSvgElement();
    description = new svg.ImageElement();
    svgBase.attributes = {
        'height': yMax.toString(),
        'width': xMax.toString(),
    };

    descriptionContainer = new DivElement();
    description.getNamespacedAttributes('http://www.w3.org/1999/xlink')['href'] = 'http://upload.wikimedia.org/wikipedia/commons/e/e9/Body_mass_index_chart.svg';
    description.attributes = {
        'height': yMax.toString(),
        'width': xMax.toString(),
    };

    svgBase.append(description);
    descriptionContainer.append(svgBase);
  }

  void initMeasurementSystemChoice() {
    measurementSystemLabel = new SpanElement();
    measurementSystemLabel.text = 'Measurement System';
    measurementSystemLabel.classes = ['icon-move'];

    measurementSystemGroup = new DivElement();
    metric = new RadioButtonInputElement();
    metric.name = 'measurementSystem';
    metric.defaultChecked = true;
    metric.onChange.listen((final Event e) => calculateMetricBMI());

    measurementSystemGroup.append(metric);
    final SpanElement metricContainer = new SpanElement();
    metricContainer.text = 'Metric (cm / kg)';
    metricContainer.title = 'm';
    measurementSystemGroup.append(metricContainer);

    imperial = new RadioButtonInputElement();
    imperial.name = 'measurementSystem';
    imperial.onChange.listen((final Event e) => calculateImperialBMI());

    measurementSystemGroup.append(imperial);
    SpanElement imperialContainer = new SpanElement();
    imperialContainer.text = 'Imperial (in / lb)';
    imperialContainer.title = 'i';
    measurementSystemGroup.append(imperialContainer);
  }

  void calculateBMI() {
    setMetaValues();

    double bmi = weightInKg / pow(lengthInCm, 2) * 1e4;
    output.value = 'BMI: ${bmi.toStringAsFixed(2)}';
  }

  void setMetaValues() {
    if (isMetricMeasurement) {
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
    lengthLabel.classes = ['icon-resize-vertical'];
  }

  void initWeightLabel() {
    weightLabel = new SpanElement();
    weightLabel.text = 'Weight ';
    weightUnitLabel = new SpanElement();
    weightUnitLabel.text = 'in kg:';
    weightLabel.classes = ['icon-dashboard'];
  }

  void initOutput() {
    output = new OutputElement();
    output.style.cssText = 'display: block';
    output.defaultValue = 'BMI';
    output.classes = ['icon-bar-chart'];
  }

  void initLengthInput() {
    length = new InputElement();
    length.type = 'number';
    length.defaultValue = '185';
    length.required = true;

    length.style.cssText = 'display: block';

    length.onChange.listen((final Event e) => showBMI());
  }

  void initWeightInput() {
    weight = new InputElement();
    weight.type = 'number';
    weight.defaultValue = '85';
    weight.required = true;

    weight.style.cssText = 'display: block';

    weight.onChange.listen((final Event e) => showBMI());
  }

  DocumentFragment get root => fragment;
}

void initApp() {
  final BMICalculator bmiCalculator = new BMICalculator();
  document.body.nodes.add(bmiCalculator.root);
}

void main() {
  initApp();
}
