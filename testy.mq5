//+------------------------------------------------------------------+
//|                                                       testuu.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#include <Trade/Trade.mqh>
CTrade trade ;

int e_point = 1000;
double e_startVolume = .01;
double e_increasePoint = .1;

string e_default_symbol_sell = "EURUSD";
string e_default_symbol_buy = "EURUSD";


string e_symbol_sell =  e_default_symbol_sell; //EURUSD

double e_point_sell ; // 0000001
double e_price_open_sell; // 1.25456
double e_price_sl_sell; // 1.12354
double e_price_tp_sell; // 1.96541
int e_point_b_sell = e_point; // 500
   
double e_volume_sell=e_startVolume; // 0.01

bool e_found_sell = false;


string e_symbol_buy = e_default_symbol_buy ;  //EURUSD

double e_point_buy ; // 0000001
double e_price_open_buy; // 1.25456
double e_price_sl_buy; // 1.12354
double e_price_tp_buy; // 1.96541
int e_point_b_buy = e_point; // 500
   
double e_volume_buy = e_startVolume;  // 0.01
   
bool e_found_buy = false;





void functionCheckPosition(){

   
   
   if(PositionsTotal() > 2){
      Print("--------Error Count Symbol---------");

      return ;
   }
   
   for(int i = 0; i<PositionsTotal(); i++){
      Print("Fooor LOOOOB");
     PositionSelectByTicket(PositionGetTicket(i));
     if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){
      e_found_sell = true;
      e_symbol_sell = PositionGetString(POSITION_SYMBOL) ;
      
      e_point_sell = SymbolInfoDouble(e_symbol_sell,SYMBOL_POINT);
      
      e_price_open_sell = PositionGetDouble(POSITION_PRICE_OPEN);
      e_price_sl_sell = PositionGetDouble(POSITION_SL);
      e_price_tp_sell = PositionGetDouble(POSITION_TP);
      
      double e__p = (e_price_open_sell - e_price_sl_sell)/e_point_sell;
      //e_point_b_sell = NormalizeDouble(e__p,0);
      e_point_b_sell = (int)e__p;
      
      e_volume_sell = PositionGetDouble(POSITION_VOLUME);
     }else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY){
     e_found_buy = true;
      e_symbol_buy = PositionGetString(POSITION_SYMBOL) ;
    //   e_bid_buy = SymbolInfoDouble(e_symbol_buy,SYMBOL_BID);
      e_point_buy = SymbolInfoDouble(e_symbol_buy,SYMBOL_POINT);

      e_price_open_buy = PositionGetDouble(POSITION_PRICE_OPEN);
      e_price_sl_buy = PositionGetDouble(POSITION_SL);
      e_price_tp_buy = PositionGetDouble(POSITION_TP);
      double e__p = (e_price_open_buy - e_price_sl_buy)/e_point_buy;
      //e_point_b_buy = NormalizeDouble(e__p,0);
      e_point_b_buy = (int)e__p ;
      
      e_volume_buy = PositionGetDouble(POSITION_VOLUME);
      Print(e_volume_buy);
     }else{
          Print("--------Error Undefiend---------");
      return ;
     }
   }
   if(e_found_sell){
      if(e_symbol_sell != e_default_symbol_sell){
         Print("--------Error Symbol Sell---------");
         return ;
      }
   }else{
        
        //<----------Sell------------->
        //double nxt_volume = (e_volume_sell * 2); // 0.02
        double bid = SymbolInfoDouble(e_default_symbol_sell,SYMBOL_BID); // 1.012364
        double point = SymbolInfoDouble(e_default_symbol_sell,SYMBOL_POINT); //  0.000001
        double point_c = e_point_b_sell * point ;
        //double point_d = point_c * point ; // .00550
        double sl = bid + point_c;  // 
        double tp = bid - point_c; 
        Print("====================");
        Print("e_volume_sell: ", e_volume_sell);
        //Print("nxt_volume: ", nxt_volume);
        Print("bid: ", bid);
        Print("point: ", point);
        //Print("point_c: ", point_c);
        //Print("point_d: ", point_d);
        Print("sl: ", sl);
        Print("tp: ", tp);
        Print("....................");
        trade.Sell(e_volume_sell,e_symbol_sell,bid,sl,tp,"SELL");
        //</----------Sell------------->
   }
   
   
   if(e_found_buy){
      if(e_symbol_buy != e_default_symbol_buy){
         Print("--------Error Symbol Buy---------");
         return ;
      }
   }else{
      //<----------Buy------------->
        //double nxt_volume = (e_volume_buy * 2); // 0.02
        double ask = SymbolInfoDouble(e_default_symbol_buy,SYMBOL_ASK); // 1.012364
        double point = SymbolInfoDouble(e_default_symbol_buy,SYMBOL_POINT); //  0.000001
        double point_c = e_point_b_buy * point ;
        //double point_d = point_c * point ; // .00550
        double sl = ask - point_c;  // 
        double tp = ask + point_c; 
        trade.Buy(e_volume_buy,e_default_symbol_buy,ask,sl,tp,"BUY");
        //</----------Buy------------->
   }
   


}





int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   functionCheckPosition();
   /*
   PositionSelectByTicket(PositionGetTicket(PositionsTotal()-1));
   Print("++++++++++++");
   Print(PositionGetDouble(POSITION_PRICE_OPEN));
    if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){
      // sell 
    }
   Print("-----------");
   */
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---
   
  }
//+------------------------------------------------------------------+
