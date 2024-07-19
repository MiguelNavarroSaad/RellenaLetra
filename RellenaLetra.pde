/*
          Los permisos para la app de Android los obtuve desde
              C:\Program Files (x86)\Android\android-sdk\cmdline-tools\7.0\bin
          con cmd.exe (línea de comandos autorizado) ejecutando
              sdkmanager --licenses (darle sí a todo)
          Eso me generó la carpeta 'licenses' en
              C:\program files (x86)\Android\android-sdk
          la cual copié a
              Documentos\Processing\android\sdk
              
          El ícono de la app está en
              Documentos\Processing\modes\AndroidMode\icons
              
          Los .png hay que ponerlos en una carpeta nueva, en donde está 
          el .pde, con el nombre 'data', para que se incluyan en la app.
          
          Las letras las hice con GIMP. lienzo: 1000x800 px;
          fuente: Segoe UI Heavy 700 px;
          utilicé Imagen > Líneas guías vertical (50%), horizontal (75%)
                  Capa > Transparencia > Añadir canal alfa
                  Seleccionar > Por color (selecioné la letra)
                  Editar > Cortar
                  Seleccionar > Todo
                  Archivo > Exportar como
*/
float diametro;
float x0[] = {0, 0, 0, 0, 0, 0, 0};
float y0;
float rojo[] = {255, 255, 255, 0, 0, 75, 159};
float verde[] = {0, 127, 255, 255, 0, 0, 0};
float azul[] = {0, 0, 0, 0, 255, 130, 255};
float r[] = {0, 0, 0, 0, 0, 0, 0};
float x, y;
float r_cambiaXY;
PGraphics Mayuscula, minuscula;
boolean cambia = true;
PFont fuente;

String Letra[] = {"LetraA.png", "LetraB.png", "LetraC.png", "LetraD.png",
                  "LetraE.png", "LetraF.png", "LetraG.png", "LetraH.png",
                  "LetraI.png", "LetraJ.png", "LetraK.png", "LetraL.png",
                  "LetraM.png", "LetraN.png", "LetraNh.png", "LetraO.png",
                  "LetraP.png", "LetraQ.png", "LetraR.png", "LetraS.png",
                  "LetraT.png", "LetraU.png", "LetraV.png", "LetraW.png",
                  "LetraX.png", "LetraY.png", "LetraZ.png"};
String letra[] = {"Azalea.png", "Bugambilia.png", "Cempasuchil.png", "Dalia.png",
                  "eee.png", "fff.png", "ggg.png", "hhh.png",
                  "iii.png", "jjj.png", "kkk.png", "lll.png",
                  "mmm.png", "nnn.png", "nhnhnh.png", "ooo.png",
                  "ppp.png", "qqq.png", "Rosa.png", "sss.png",
                  "ttt.png", "uuu.png", "vvv.png", "www.png",
                  "xxx.png", "yyy.png", "zzz.png"};

PImage miLetra, miletra;
int indiceLetras;

void setup() {
  size(500, 500); // 500, 500; 1000, 1000
  frameRate(10);
  indiceLetras = floor(random(27));
  miLetra = loadImage(Letra[indiceLetras]);
  miletra = loadImage(letra[indiceLetras]);
  diametro = width/8;
  for (int i= 0; i < 7; i++) x0[i] = 9*diametro/16+i*(9*diametro/8);
  y0 = height - diametro;
  Mayuscula = createGraphics(width, height);
  crea(Mayuscula);
  image(Mayuscula, 0, 0);
  minuscula = createGraphics(width, height);
  crea(minuscula);
  fuente = createFont("SansSerif", 48);
}

void draw() {
  x = mouseX;
  y = mouseY;
  r_cambiaXY = sqrt((x-(x0[5]+x0[6])/2)*(x-(x0[5]+x0[6])/2)
               + (y-y0+0.75*diametro)*(y-y0+0.75*diametro));
  if (r_cambiaXY < diametro/2 && mousePressed) cambia = !cambia;
  if (!cambia) {
    minuscula.beginDraw();
  minuscula.pushMatrix(); minuscula.translate(0, 0); minuscula.scale(0.5); // ojo
    minuscula.image(miletra, 0, 0);
  minuscula.popMatrix();
    minuscula.endDraw();
    boton(minuscula, "May\u00fascula");
    image(minuscula, 0, 0);
    colorea(minuscula);
  }
  else {
    Mayuscula.beginDraw();
  Mayuscula.pushMatrix(); Mayuscula.translate(0, 0); Mayuscula.scale(0.5); // ojo
    Mayuscula.image(miLetra, 0, 0);
  Mayuscula.popMatrix();
    Mayuscula.endDraw();
    boton(Mayuscula, "min\u00fascula");
    image(Mayuscula, 0, 0);
    colorea(Mayuscula);
  }
}

void crea(PGraphics pagina) {
  pagina.beginDraw();
  pagina.background(255, 255, 255);
  pagina.noStroke();
  for (int indice = 0; indice < 7; indice++) {
    pagina.fill(rojo[indice], verde[indice], azul[indice]);
    pagina.circle(x0[indice], y0, diametro);
  }
  pagina.endDraw();
}

void boton(PGraphics pagina, String letra) {
  pagina.beginDraw();
  pagina.pushMatrix();
  pagina.translate((x0[3]+x0[6])/2, y0-0.75*diametro);
  pagina.strokeWeight(10);
  pagina.fill(0, 0, 0);
  pagina.textFont(fuente);
  pagina.textSize(24); // 24, 48
  pagina.text(letra, 0, 0);
  pagina.popMatrix();
  pagina.strokeWeight(25);
  pagina.endDraw();
}

void colorea(PGraphics pagina) {
  if (mouseY >= (y0-(diametro))) {
    for (int indice = 0; indice < 7; indice++) {
      r[indice] =  sqrt((x-x0[indice])*(x-x0[indice]) + (y-y0)*(y-y0));
      if (r[indice] < diametro/2) {
        pagina.beginDraw();
        pagina.stroke(rojo[indice], verde[indice], azul[indice]);
        pagina.strokeWeight(25);
        pagina.endDraw();
      }
    }
  }
  else {
    pagina.beginDraw();
    pagina.line(pmouseX, pmouseY, mouseX, mouseY);
    pagina.endDraw();
  }
}
