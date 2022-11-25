//https://www.mql5.com/en/docs/array/arrayprint
//https://www.mql5.com/en/docs/array

// https://www.mql5.com/en/docs/event_handlers

// https://www.mql5.com/en/docs/constants/environment_state/accountinformation
// https://www.mql5.com/en/docs/constants/environment_state

// https://www.mql5.com/en/docs/predefined

// https://www.mql5.com/en/docs/standardlibrary/tradeclasses
// https://www.mql5.com/en/docs/standardlibrary

/*
// https://www.mql5.com/en/docs/constants/indicatorconstants/enum_ma_method
// https://www.mql5.com/en/docs/constants/indicatorconstants
// https://www.mql5.com/en/docs/constants/chartconstants/enum_timeframes
// https://www.mql5.com/en/docs/constants/chartconstants
*/

// https://www.mql5.com/en/docs/dateandtime

//https://www.mql5.com/en/docs/common

//https://www.mql5.com/en/docs/eventfunctions

// https://www.mql5.com/en/docs/trading

// https://www.mql5.com/en/docs/marketinformation

// https://www.mql5.com/en/docs/indicators

#include <Trade/Trade.mqh>
CTrade trade ;

int OnInit()
  {

   EventSetTimer(1);


    Print("----------------------");
    int Variable[] = {1,2,3,4,5,6};
    ArrayPrint(Variable,_Digits,"\n");
    Print("----------------------");
    Alert(TimeCurrent());
    MessageBox("HI");
    Comment("\n\n\n Symbol: ",_Symbol);
    PrintFormat(AccountInfoDouble(ACCOUNT_BALANCE));

    Strin

    return(INIT_SUCCEEDED);
  

  }

  void OnTimer()
  {
    EventKillTimer();
  }

void OnTick()
  {

    /*
      static datetime timestamp; // 1970.01.01 00:00:00
      datetime time = iTime(_Symbol,PERIOD_CURRENT,0);   
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
           trade.Buy(0.01,_Symbol,ask,sl,tp,"this is a buy");
        }
        if(fastMaArray[0] < slowMaArray[0] && fastMaArray[1] > slowMaArray[1]){
           Print("Fast Ma Is now < Than Slow Ma");
           double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID); // exm: 1.101421
           double point = SymbolInfoDouble(_Symbol,SYMBOL_POINT); //  0.000001
           double sl = bid + (100*point); 
           double tp = bid - (100*point); 
           trade.Sell(0.01,_Symbol,bid,sl,tp,"this is a sell");
      }
    */


    static datetime timestamp; // 1970.01.01 00:00:00
    datetime time = iTime(_Symbol,PERIOD_CURRENT,0);
    if(timestamp != time){
      timestamp = time;   
      if(PositionsTotal() == 0){
        if(willOrder == "BUY"){
            double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK); // exm: 1.101421
            double point = SymbolInfoDouble(_Symbol,SYMBOL_POINT); //  0.000001
            double sl = ask - (100*point); 
            double tp = ask + (100*point); 
            Comment("\n\n\n" , sl);
            trade.Buy(0.01,_Symbol,ask,sl,tp,"this is a buy"); 
            willOrder = "SELL" ;
        }else{
            double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID); // exm: 1.101421
            double point = SymbolInfoDouble(_Symbol,SYMBOL_POINT); //  0.000001
            double sl = bid + (100*point); 
            double tp = bid - (100*point); 
            Comment("\n\n\n" , sl);
            trade.Sell(0.01,_Symbol,bid,sl,tp,"this is a sell");
            willOrder = "BUY" ;
        } 
      }
    }
      

  }


  
  
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {

    //Print(trans.deal)

    Print(EnumToString(trans.type));
  }