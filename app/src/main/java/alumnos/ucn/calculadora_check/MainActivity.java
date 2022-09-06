package alumnos.ucn.calculadora_check;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    EditText num1, num2;
    CheckBox suma, resta, multiplicacion, division;
    Button calcular;
    TextView resultado;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        num1 = (EditText) findViewById(R.id.num1);
        num2 = (EditText) findViewById(R.id.num2);
        suma = (CheckBox) findViewById(R.id.sumar);
        resta = (CheckBox) findViewById(R.id.restar);
        multiplicacion = (CheckBox) findViewById(R.id.multiplicar);
        division = (CheckBox) findViewById(R.id.dividir);



        suma.setOnClickListener(this);
        resta.setOnClickListener(this);
        multiplicacion.setOnClickListener(this);
        division.setOnClickListener(this);

        resultado = (TextView) findViewById(R.id.resultado);
    }


    @Override
    public void onClick(View i) {

        String numero1 = num1.getText().toString();
        String numero2 = num2.getText().toString();

        double doble1 = Double.parseDouble(numero1);
        double doble2 = Double.parseDouble(numero2);

        String respuesta = "";
        String nada = "No se a seleccionado ningun checkbox";

        if (suma.isChecked() == true) {
            double suma = doble1 + doble2;
            respuesta = " Suma: " + suma + "/";
        }
        if (resta.isChecked() == true) {
            double resta = doble1 - doble2;
            respuesta = respuesta + " resta: " + resta + "/";
        }
        if (multiplicacion.isChecked() == true) {
            double multiplicacion = doble1 * doble2;
            respuesta = respuesta + " Multiplicacion: " + multiplicacion + "/";
        }
        if (division.isChecked() == true) {
            double division = doble1 / doble2;
            respuesta = respuesta + " Division: " + division;
        }
        resultado.setText(respuesta);

    }

}

