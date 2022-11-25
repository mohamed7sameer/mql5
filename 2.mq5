
//https://www.youtube.com/watch?v=T78Q7K3c11s&list=PLeQQbTeiG3sD5QS8ExpmRoJGz1vvFz4nv

// indicator coil
// moving average handler
// timeframe -- https://www.mql5.com/en/docs/constants/chartconstants/enum_timeframes (PERIOD_CURRENT)
// movig average -- https://www.mql5.com/en/docs/constants/indicatorconstants/enum_ma_method
//                  https://www.mql5.com/en/docs/indicators/ima

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   Print(_Symbol); //EXM..   -> EURUSD
 
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
      
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
 
   //iMA("symbol_name","timeframe","ma_period","ma_shift","ma_method","applied_price_or_handle")
   
   int handleSlowSma = iMA(_Symbol,PERIOD_CURRENT,1,0,MODE_EMA,PRICE_CLOSE);

   
   
   
  }
//+------------------------------------------------------------------+
