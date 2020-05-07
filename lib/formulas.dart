import './constants.dart';
class AtlyginimuSkaiciuokle {
  double NPD;
  double antPopieriaus;
  double pensijosImoka;
  double darbdavioGrupe;
  double iRankas;
  double GPM;
  double PSD;
  double VSD;
  double Pensija;
  double darbdavioSodra;
  double sutariesRusis;
  int npdGrupe;

  AtlyginimuSkaiciuokle(this.pensijosImoka, this.darbdavioGrupe, this.sutariesRusis);

  void setNpd(double npd){
    if(npd == 0){
      this.NPD = 350-0.17*(antPopieriaus - Constants().MMA);
    }else{
      this.NPD = npd;

    }
  }
  void setAntPopieriaus(double input){
    this.antPopieriaus = input;
  }
  void setIRankas(double input){
    this.iRankas = input;
  }


  List<double> getIRankas(){
    //print(NPD);
    if(antPopieriaus < Constants().MMA){
      NPD = 350;
    }
    if(NPD<0){
      NPD = 0;
    }
    GPM = (antPopieriaus - NPD )*0.2;
    if(GPM < 0){
      GPM = 0;
    }

    PSD = antPopieriaus*0.0698;
    VSD = antPopieriaus*0.1252;
    Pensija = antPopieriaus*pensijosImoka;
    iRankas = antPopieriaus-(GPM+PSD+VSD+Pensija);
    darbdavioSodra = antPopieriaus*(0.0131+0.0016+0.0016+darbdavioGrupe+sutariesRusis);
    List<double> list =new List<double>();
    list.add(GPM);
    list.add(PSD);
    list.add(VSD);
    list.add(Pensija);
    list.add(iRankas);
    list.add(darbdavioSodra);
    list.add(NPD);
    list.add(antPopieriaus+darbdavioSodra);

    /*
    [0] GPM
    [1] PSD
    [2] VSD
    [3] Pensija
    [4] iRankas
    [5] darbdavioSodra
    [6] NPD
    [7] visa kaina


     */
    return list;
  }
  List<double> getAntPopieriaus(){
    List<double> list =new List<double>();

  }
}
class IndividualiosVeiklosSkaiciuokle{
  double pajamos;
  double sanaudos;
  int sanauduTipas;
  double pensijosImoka;
  double taikomasGPM;

  double GPM;

  IndividualiosVeiklosSkaiciuokle(this.pajamos, this.sanaudos, this.pensijosImoka, this.sanauduTipas);

  List<double> getPelnas(){
    List<double> list = new List<double>();
    double apmokestinamos;

    if(sanauduTipas == 1){
      apmokestinamos = pajamos*0.7;
    }else{
      apmokestinamos = pajamos-sanaudos;
    }
    double baze = apmokestinamos*0.9;
    double lubos_high = Constants().VDU*43;

    if(apmokestinamos>=lubos_high){
      baze = lubos_high;
    }
    var vsd = baze*(Constants().VSD+pensijosImoka);
    var pensija = baze*pensijosImoka;
    var psd = baze*Constants().PSD;
    list.add(baze);
    list.add(vsd);
    list.add(psd);
    list.add(pensija);

    // tik gpm
    if(apmokestinamos<20000) {
      GPM = apmokestinamos*0.15-apmokestinamos*0.1;
    }else if(apmokestinamos>20000 && apmokestinamos<35000){
      GPM = apmokestinamos*0.15-apmokestinamos*(0.1-2/300000*(apmokestinamos-20000));
    }else if(apmokestinamos>35000){
      GPM = apmokestinamos*0.15;
    }
    var pelnas = apmokestinamos-vsd-psd-GPM;

    list.add(GPM);
    list.add(GPM/apmokestinamos);
    list.add(pelnas);
    /*
    [0] BAZE
    [1] vsd
    [2] psd
    [3] pensija
    [4] gpm
    [5] gpm tarifas
    [6] pelnas
     */
    return list;
  }
}