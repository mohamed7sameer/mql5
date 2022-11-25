// importing code
// object variable
// open position
// stop lose 
// take profit
// https://www.forexeadvisor.com/

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

#include <Trade/Trade.mqh>

CTrade trade ;

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
  
  static datetime timestamp; // 1970.01.01 00:00:00
  datetime time = iTime(_Symbol,PERIOD_CURRENT,0);
  datetime test = TimeCurrent(); // from me
  
  
   if(timestamp != time){
      timestamp = time;
      static int handleSlowMa = iMA(_Symbol,PERIOD_CURRENT,200,0,MODE_EMA,PRICE_CLOSE);
      double slowMaArray[];
      CopyBuffer(handleSlowMa,0,1,2,slowMaArray);
      ArraySetAsSeries(slowMaArray,true);
      
      static int handleFastMa = iMA(_Symbol,PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE);
      double fastMaArray[];
      CopyBuffer(handleFastMa,0,1,2,fastMaArray);
      ArraySetAsSeries(fastMaArray,true);
      
      
      
      if(fastMaArray[0] > slowMaArray[0] && fastMaArray[1] < slowMaArray[1]){
         Print("Fast Ma Is now > Than Slow Ma");
         
         double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK); // exm: 1.101421
         double point = SymbolInfoDouble(_Symbol,SYMBOL_POINT); //  0.000001
         double sl = ask - (100*point); 
         double tp = ask + (100*point); 
         Comment("\n\n\n" , sl);
         trade.Buy(0.01,_Symbol,ask,sl,tp,"this is a buy");
      }
      
      if(fastMaArray[0] < slowMaArray[0] && fastMaArray[1] > slowMaArray[1]){
         Print("Fast Ma Is now < Than Slow Ma");
         
         double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID); // exm: 1.101421
         double point = SymbolInfoDouble(_Symbol,SYMBOL_POINT); //  0.000001
         double sl = bid + (100*point); 
         double tp = bid - (100*point); 
         Comment("\n\n\n" , sl);
         trade.Sell(0.01,_Symbol,bid,sl,tp,"this is a sell");
      }
      
      //Comment("\n\n",handleSlowMa[0],"_\n\n\n" , slowMaArray[0]);
      
      /*
      Comment("\n\nslowMaArray1: ",slowMaArray[0],
      "\n\nslowMaArray2: ",slowMaArray[1],
      "\n\nsfastMaArray1: ",fastMaArray[0],
      "\n\nfastMaArray2: ",fastMaArray[1]
      );
      */
    }
     
 
  }
//+------------------------------------------------------------------+
