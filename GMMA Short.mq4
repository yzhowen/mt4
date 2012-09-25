//+------------------------------------------------------------------+
//|                                                   GMMA Short.mq4 |
//|                                      Copyright 2012,       mhiki |
//|                                        http://mhiki.blogspot.jp/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2012, mhiki"
#property link      "http://mhiki.blogspot.jp/"

#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 Red
#property indicator_color2 OrangeRed
#property indicator_color3 Tomato
#property indicator_color4 Coral
#property indicator_color5 Orange
#property indicator_color6 Yellow


int MA_PERIODS[6] = {3, 5, 8, 10, 12, 15};
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double ExtMapBuffer4[];
double ExtMapBuffer5[];
double ExtMapBuffer6[];

int init()
{
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));   
   IndicatorShortName("GMMA Short");

   for (int i = 0; i < 6; i++) {
      SetIndexStyle(i, DRAW_LINE);
      SetIndexShift(i, 0);
      SetIndexDrawBegin(i, MA_PERIODS[i] - 1);
   }
   SetIndexBuffer(0, ExtMapBuffer1);
   SetIndexBuffer(1, ExtMapBuffer2);
   SetIndexBuffer(2, ExtMapBuffer3);
   SetIndexBuffer(3, ExtMapBuffer4);
   SetIndexBuffer(4, ExtMapBuffer5);
   SetIndexBuffer(5, ExtMapBuffer6);

   return(0);
}


int deinit()
{
    return(0);
}


int start()
{
    int counted_bars;
    int pos;
    double pr[6];
    
    if (Bars <= MA_PERIODS[0]) return(0);

    counted_bars = IndicatorCounted();

    if (counted_bars < 0) return(-1);
    if (counted_bars > 0) counted_bars--;
    
    pos = Bars - 2;

    if(counted_bars > 2) pos = Bars - counted_bars - 1;    
    
    for (int i = 0; i < 6; i++) {
        pr[i] = 2.0 / (MA_PERIODS[i] + 1);
    }
    
    while (pos >= 0) {
        if (pos == Bars - 2) ExtMapBuffer1[pos + 1] = Close[pos + 1];        
        if (pos == Bars - 2) ExtMapBuffer2[pos + 1] = Close[pos + 1];        
        if (pos == Bars - 2) ExtMapBuffer3[pos + 1] = Close[pos + 1];        
        if (pos == Bars - 2) ExtMapBuffer4[pos + 1] = Close[pos + 1];        
        if (pos == Bars - 2) ExtMapBuffer5[pos + 1] = Close[pos + 1];        
        if (pos == Bars - 2) ExtMapBuffer6[pos + 1] = Close[pos + 1];        
        ExtMapBuffer1[pos] = Close[pos] * pr[0] + ExtMapBuffer1[pos + 1] * (1 - pr[0]);
        ExtMapBuffer2[pos] = Close[pos] * pr[1] + ExtMapBuffer2[pos + 1] * (1 - pr[1]);
        ExtMapBuffer3[pos] = Close[pos] * pr[2] + ExtMapBuffer3[pos + 1] * (1 - pr[2]);
        ExtMapBuffer4[pos] = Close[pos] * pr[3] + ExtMapBuffer4[pos + 1] * (1 - pr[3]);
        ExtMapBuffer5[pos] = Close[pos] * pr[4] + ExtMapBuffer5[pos + 1] * (1 - pr[4]);
        ExtMapBuffer6[pos] = Close[pos] * pr[5] + ExtMapBuffer6[pos + 1] * (1 - pr[5]);
        
 	     pos--;
    }
    
    return(0);
}

