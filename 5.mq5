// copy buffer
// buffer number
// array -- 
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
 
   int handleSlowSma = iMA(_Symbol,PERIOD_CURRENT,1,0,MODE_EMA,PRICE_CLOSE);

   double slowMaArray[];
   
   
   CopyBuffer(handleSlowSma,0,1,2,slowMaArray);
   
   
   Comment("\n\ntest: ",slowMaArray[0],
   "\n\ntest2: ",slowMaArray[1]
   );
  
 
  }
//+------------------------------------------------------------------+
