#library('loxal:BMI_calculator');

#import('dart:html');
#import('dart:math');

class BMICalculator {
    DivElement container;
    SpanElement lengthLabel;
    InputElement length;
    SpanElement weightLabel;
    InputElement weight;
    ButtonElement calculateBMIButton;
    DocumentFragment fragment;
    OutputElement output;

    BMICalculator() {
        initWidget();
    }

    void initWidget() {
        initElements();
        attachElements();
        attachToRoot();
    }

    void attachToRoot() {
        fragment = new DocumentFragment();
        fragment.elements.add(container);
    }

    void attachElements() {
        container = new DivElement();
        container.elements.add(lengthLabel);
        container.elements.add(length);
        container.elements.add(weightLabel);
        container.elements.add(weight);
        container.elements.add(calculateBMIButton);
        container.elements.add(output);
    }

    void initElements() {
        initLengthLabel();
        initLengthInput();
        initWeightLabel();
        initWeightInput();
        initCalculateButton();
        initOutput();
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
        length.valueAsNumber = 185;
        length.required = true;

        length.style.cssText = 'display: block';

        length.on.change.add((final Event e) => calculateBMI());
    }

    void initWeightInput(){
        weight = new InputElement('number');
        weight.valueAsNumber = 85;
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